defmodule OpenPantry.MealTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Meal

  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
