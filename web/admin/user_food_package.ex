defmodule OpenPantry.ExAdmin.UserFoodPackage do
  use ExAdmin.Register
  alias OpenPantry.Repo
  register_resource OpenPantry.UserFoodPackage do

  end

  @spec display_name(%UserFoodPackage{}) :: String.t
  def display_name(user_food_package) do
    user_name = Repo.preload(user_food_package, :user).user.name <> " "
    inserted_at =  user_food_package.inserted_at
                |> NaiveDateTime.to_date()
                |> Date.to_string()
    user_name <> inserted_at
  end
end
