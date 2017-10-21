defmodule OpenPantry.ExAdmin.Stock do
  use ExAdmin.Register
  alias OpenPantry.Stock
  alias OpenPantry.Facility
  register_resource OpenPantry.Stock do
    form stock do
      inputs do
        input stock, :packaging
        input stock, :quantity
        input stock, :arrival
        input stock, :expiration
        input stock, :reorder_quantity
        input stock, :weight
        input stock, :aisle
        input stock, :row
        input stock, :shelf
        input stock, :credits_per_package
        input stock, :max_per_package
        input stock, :max_per_person
        input stock, :storage, RefrigerationEnum
        input stock, :image, OpenPantry.Image.Type
        input stock, :food, collection: OpenPantry.Food.all
        input stock, :facility, collection: Facility.all
      end
    end

    scope :sorted_by_food, [default: true], fn(query) ->
      case query do
        %Ecto.Query{} ->
          query
          |> exclude(:order_by)
          |> join(:left, [s], f in assoc(s, :food))
          |> order_by([s, f], asc: f.longdesc)
        _ ->
          query
      end
    end
    scope :all, default: false
  end

  def display_name(stock) do
    Stock.stockable_name(stock) <> " " <> (stock.packaging || "")
  end
end
