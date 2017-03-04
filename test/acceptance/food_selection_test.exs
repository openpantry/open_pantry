defmodule OpenPantry.FoodSelectionTest do
  use OpenPantry.AcceptanceCase, async: true
  import OpenPantry.Factory

  def complete_facility(type_count) do
    facility = insert(:facility)
    user = insert(:user, facility: facility)
    food_groups = for _ <- 1..type_count do
      insert(:food_group)
    end
    foods = for food_group <- food_groups do
      insert(:food, food_group: food_group)
    end
    stocks = for food <- foods do
      insert(:stock, facility: facility, food: food)
    end
    credit_types = for food_group <- food_groups do
      insert(:credit_type, food_groups: [food_group])
    end
    user_credits = for credit_type <- credit_types do
      insert(:user_credit, credit_type: credit_type, user: user )
    end
    %{credit_types: credit_types,
      facility: facility,
      user: user,
      user_credits: user_credits,
      stocks: stocks,
      foods: foods,
      food_groups: food_groups
    }
  end

  test "selection table has tab per credit type, plus meals and cart", %{session: session} do
    %{credit_types: [credit_type|_]} = complete_facility(2)

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    assert first_credit =~ ~r/#{credit_type.name}/
  end

  test "selection table shows first foods in stock on load", %{session: session} do
    %{credit_types: [credit_type|_], foods: [food|_]} = complete_facility(2)

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    assert first_credit =~ ~r/#{food.longdesc}/
  end

  test "selection table does not show second food in stock on load", %{session: session} do
    %{credit_types: [credit_type|_], foods: [_|[food2]]} = complete_facility(2)

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    refute first_credit =~ ~r/#{food2.longdesc}/
  end

  test "selection table allows selecting second tab", %{session: session} do
    %{credit_types: [_|[credit_type2]], foods: [_|[food2]]} = complete_facility(2)

    second_credit = session
    |> visit("/en/food_selections")
    |> click_link(credit_type2.name)
    |> find("##{credit_type2.name}")
    |> text

    assert second_credit =~ ~r/#{food2.longdesc}/
  end
end