defmodule OpenPantry.Web.DisplayLogic do

  def active(first_type, [{first_type, _, _}|_tail]), do: "active"
  def active(_, [{_, _, _}|_tail]), do: ""

  def quantity(stock, package) do
    if sd = Enum.find(package.stock_distributions, &(&1.stock_id == stock.id)) do
      sd.quantity
    else
      0
    end
  end

  def display_stock_type(stock_struct) do
    stock_struct
    |> to_string
    |> String.split(".")
    |> List.last
  end

end
