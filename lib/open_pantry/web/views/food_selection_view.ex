defmodule OpenPantry.Web.FoodSelectionView do
  use OpenPantry.Web, :view
  import OpenPantry.Web.DisplayLogic
  alias OpenPantry.Web.SharedView

  def food_by_group(credit_food_groups) do
    Enum.reduce(credit_food_groups, %{}, &(Map.put(&2, &1.name, &1.foods)))
  end

  def storage_temperatures do
    RefrigerationEnum.__enum_map__
  end

  def display(temperature) do
    Atom.to_string(temperature)
    |> String.replace("_", " ")
    |> String.replace_prefix("", "Items stored in ")
    |> String.replace_suffix("", " storage are colored like this ")
  end

end
