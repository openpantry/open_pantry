defmodule OpenPantry.FoodHandoffTest do
  use OpenPantry.ModelCase

  alias OpenPantry.FoodHandoff

  @valid_attrs %{finalized: true, ready_for_pickup: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FoodHandoff.changeset(%FoodHandoff{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FoodHandoff.changeset(%FoodHandoff{}, @invalid_attrs)
    refute changeset.valid?
  end
end
