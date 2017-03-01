defmodule OpenPantry.StockTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Stock

  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = Stock.changeset(%Stock{}, @invalid_attrs)
    refute changeset.valid?
  end
end
