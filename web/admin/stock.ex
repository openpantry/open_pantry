defmodule OpenPantry.ExAdmin.Stock do
  use ExAdmin.Register
  alias OpenPantry.Repo
  register_resource OpenPantry.Stock do

  end

  def display_name(property) do
    Repo.preload(property, :food).food.name <> " " <> property.packaging
  end
end
