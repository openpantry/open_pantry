defmodule OpenPantry.StockTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Stock

  @valid_attrs %{arrival: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, expiration: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, quantity: 42, reorder_quantity: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stock.changeset(%Stock{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stock.changeset(%Stock{}, @invalid_attrs)
    refute changeset.valid?
  end
end
