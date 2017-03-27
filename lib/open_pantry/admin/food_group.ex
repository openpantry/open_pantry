defmodule OpenPantry.ExAdmin.FoodGroup do
  use ExAdmin.Register

  register_resource OpenPantry.FoodGroup do

  end

  def display_name(food_group) do
    food_group.foodgroup_desc
  end
end
