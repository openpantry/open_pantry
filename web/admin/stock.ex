defmodule OpenPantry.ExAdmin.Stock do
  use ExAdmin.Register
  alias OpenPantry.Repo
  alias OpenPantry.Stock
  register_resource OpenPantry.Stock do

  end

  def display_name(stock) do
    Stock.stockable_name(stock) <> " " <> (stock.packaging || "")
  end
end
