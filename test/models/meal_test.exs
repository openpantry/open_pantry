defmodule OpenPantry.MealTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Meal

  @valid_attrs %{calcium: 42, calories: 42, calories_from_fat: 42, carbohydrate: 42, cholesterol: 42, description: "some content", dessert: "some content", entree: "some content", fat: 42, fiber: 42, protein: 42, saturated_fat: 42, side_dish1: "some content", side_dish2: "some content", sodium: 42, sugars: 42, weight: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meal.changeset(%Meal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
