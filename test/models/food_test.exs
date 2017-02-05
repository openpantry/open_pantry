defmodule OpenPantry.FoodTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Food

  @valid_attrs %{calcium: 42, calories: 42, calories_from_fat: 42, carbohydrate: 42, cholesterol: 42, description: "some content", fat: 42, fiber: 42, name: "some content", protein: 42, saturated_fat: 42, serving_size: "120.5", sodium: 42, sugars: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Food.changeset(%Food{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Food.changeset(%Food{}, @invalid_attrs)
    refute changeset.valid?
  end
end
