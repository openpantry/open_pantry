defmodule OpenPantry.FoodSelectionTest do
  use OpenPantry.AcceptanceCase, async: true

  import OpenPantry.CompleteFacility
  import Wallaby.Query, only: [css: 2, button: 1]

  test "selection table has tab per credit type, plus meals and cart", %{session: session} do
    %{credit_types: [credit_type|_]} = two_credit_facility()

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    assert first_credit =~ ~r/#{credit_type.name}/
  end

  test "selection table shows first foods in stock on load", %{session: session} do
    %{credit_types: [credit_type|_], foods: [food|_]} = two_credit_facility()

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    assert first_credit =~ ~r/#{food.longdesc}/
  end

  test "selection table does not show second food in stock on load", %{session: session} do
    %{credit_types: [credit_type|_], foods: [_|[food2]]} = two_credit_facility()

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    refute first_credit =~ ~r/#{food2.longdesc}/
  end

  test "selection table allows selecting second tab", %{session: session} do
    %{credit_types: [_|[credit_type2]], foods: [_|[food2]]} = two_credit_facility()

    second_credit = session
    |> visit("/en/food_selections")
    |> click_link(credit_type2.name)
    |> find("##{credit_type2.name}")
    |> text

    assert second_credit =~ ~r/#{food2.longdesc}/
  end

  test "clicking + adds to cart, decrements stock quantity", %{session: session} do
    one_credit_facility()
    session = visit(session, "/en/food_selections")

    take_screenshot session
    assert has?(session, stock_available(20))
    assert has?(session, stock_requested(0))

    click(session, button("+"))

    assert has?(session, stock_available(19))
    assert has?(session, stock_requested(1))

    take_screenshot session
  end

  def stock_available(count), do: css(".js-available-quantity", text: "#{count}")
  def stock_requested(count), do: css(".js-current-quantity", text: "#{count}")
end
