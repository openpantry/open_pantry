defmodule OpenPantry.FoodSelectionTest do
  use OpenPantry.AcceptanceCase, async: true
  import OpenPantry.Factory

  def complete_facility do
    facility = insert(:facility)
    user = insert(:user, facility: facility)
    food_group = insert(:food_group)
    food = insert(:food, food_group: food_group)
    stock = insert(:stock, facility: facility, food: food)
    credit_type = insert(:credit_type, food_groups: [food_group])
    insert(:user_credit, credit_type: credit_type, user: user )
    %{credit_type: credit_type, facility: facility, user: user, stock: stock, food: food, food_group: food_group}
  end


  @tag timeout: Ownership.timeout
  test "selection table has tab per credit type, plus meals and cart", %{session: session} do
    %{credit_type: credit_type} = complete_facility()

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    assert first_credit =~ ~r/#{credit_type.name}/
  end
end