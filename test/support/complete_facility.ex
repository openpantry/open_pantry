defmodule OpenPantry.CompleteFacility do
  import OpenPantry.Factory

  def one_credit_facility(), do: credit_types(1)

  def two_credit_facility(), do: credit_types(2)


  def credit_types(type_count) when is_integer(type_count) do
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



end