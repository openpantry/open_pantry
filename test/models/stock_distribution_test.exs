defmodule OpenPantry.StockDistributionTest do
  use OpenPantry.ModelCase

  alias OpenPantry.StockDistribution

  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = StockDistribution.changeset(%StockDistribution{}, @invalid_attrs)
    refute changeset.valid?
  end
end
