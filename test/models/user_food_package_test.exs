defmodule OpenPantry.UserFoodPackageTest do
  use OpenPantry.ModelCase

  alias OpenPantry.UserFoodPackage

  @valid_attrs %{finalized: true, ready_for_pickup: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserFoodPackage.changeset(%UserFoodPackage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserFoodPackage.changeset(%UserFoodPackage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
