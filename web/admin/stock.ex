defmodule OpenPantry.ExAdmin.Stock do
  use ExAdmin.Register
  alias OpenPantry.Repo
  alias OpenPantry.Stock
  register_resource OpenPantry.Stock do

  end

  # def display_name(stock) do
  #   Stock.stock_item(stock).name <> " " <> (stock.packaging || "")
  # end
end
