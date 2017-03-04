defmodule OpenPantry.Web.FoodSelectionView do
  use OpenPantry.Web, :view
  import OpenPantry.Web.DisplayLogic

  def food_by_group(credit_food_groups) do
    Enum.reduce(credit_food_groups, %{}, &(Map.put(&2, &1.name, &1.foods)))
  end

end
