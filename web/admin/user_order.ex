defmodule OpenPantry.ExAdmin.UserOrder do
  use ExAdmin.Register
  alias OpenPantry.Repo
  register_resource OpenPantry.UserOrder do

  end

  @spec display_name(UserOrder.t) :: String.t
  def display_name(user_order) do
    user_name = Repo.preload(user_order, :user).user.name <> " "
    inserted_at =  user_order.inserted_at
                |> NaiveDateTime.to_date()
                |> Date.to_string()
    user_name <> inserted_at
  end
end
