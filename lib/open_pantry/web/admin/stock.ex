defmodule OpenPantry.ExAdmin.Stock do
  use ExAdmin.Register
  alias OpenPantry.Stock
  alias OpenPantry.Facility
  register_resource OpenPantry.Stock do
    form stock do
      inputs do
        input stock, :quantity
        input stock, :packaging
        input stock, :quantity
        input stock, :arrival
        input stock, :expiration
        input stock, :reorder_quantity
        input stock, :weight
        input stock, :aisle
        input stock, :row
        input stock, :shelf
        input stock, :packaging
        input stock, :credits_per_package
        # input stock, :food, collection: OpenPantry.Food.all
        input stock, :facility, collection: Facility.all
      end


    end
  end

  def display_name(stock) do
    Stock.stockable_name(stock) <> " " <> (stock.packaging || "")
  end
end
