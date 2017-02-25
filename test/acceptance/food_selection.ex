defmodule OpenPantry.FoodSelectionTest do
  use OpenPantry.AcceptanceCase, async: true
  import OpenPantry.Factory

  test "selection table has tab per credit type, plus meals and cart", %{session: session} do
      facility = insert(:facility)
      user = insert(:user, facility: facility)
      food_group = insert(:food_group)
      food = insert(:food, food_group: food_group)
      insert(:stock, facility: facility, food: food)
      credit_type = insert(:credit_type, food_groups: [food_group])
      insert(:user_credit, credit_type: credit_type, user: user )

      first_credit = session
      |> visit("/en/food_selections")
      |> find(Query.css("##{credit_type.name}"))
      |> text

      assert first_credit == credit_type.name
  end
end