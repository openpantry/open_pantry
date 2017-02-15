defmodule OpenPantry.FoodSelectionView do
  use OpenPantry.Web, :view
  alias OpenPantry.Repo
  require IEx
  def food_groups do
    Enum.map(@credit_types, &(&1.food_groups) |> Repo.preload(:foods))
  end

  def food_by_group(credit_food_groups) do
    Enum.reduce(credit_food_groups, %{}, &(Map.put(&2, &1.name, &1.foods)))
  end

  def display_stock_type(stock_struct) do
    stock_struct
    |> to_string
    |> String.split(".")
    |> List.last
  end

end
