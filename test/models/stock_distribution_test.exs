defmodule OpenPantry.StockDistributionTest do
  use OpenPantry.ModelCase

  alias OpenPantry.StockDistribution

  @valid_attrs %{quantity: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = StockDistribution.changeset(%StockDistribution{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = StockDistribution.changeset(%StockDistribution{}, @invalid_attrs)
    refute changeset.valid?
  end
end
