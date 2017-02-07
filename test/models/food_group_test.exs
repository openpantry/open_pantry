defmodule OpenPantry.FoodGroupTest do
  use OpenPantry.ModelCase

  alias OpenPantry.FoodGroup

  @valid_attrs %{monthly_credits: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FoodGroup.changeset(%FoodGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FoodGroup.changeset(%FoodGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
