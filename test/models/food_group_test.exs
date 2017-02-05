defmodule OpenPantry.FoodGroupTest do
  use OpenPantry.ModelCase

  alias OpenPantry.FoodGroup

  @valid_attrs %{daily_servings: 42, exclusive: true, name: "some content"}
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
