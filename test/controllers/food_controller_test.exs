defmodule OpenPantry.FoodControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.Food
  @valid_attrs %{calcium: 42, calories: 42, calories_from_fat: 42, carbohydrate: 42, cholesterol: 42, description: "some content", fat: 42, fiber: 42, name: "some content", protein: 42, saturated_fat: 42, serving_size: "120.5", sodium: 42, sugars: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, food_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing foods"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, food_path(conn, :new)
    assert html_response(conn, 200) =~ "New food"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, food_path(conn, :create), food: @valid_attrs
    assert redirected_to(conn) == food_path(conn, :index)
    assert Repo.get_by(Food, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, food_path(conn, :create), food: @invalid_attrs
    assert html_response(conn, 200) =~ "New food"
  end

  test "shows chosen resource", %{conn: conn} do
    food = Repo.insert! %Food{}
    conn = get conn, food_path(conn, :show, food)
    assert html_response(conn, 200) =~ "Show food"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, food_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    food = Repo.insert! %Food{}
    conn = get conn, food_path(conn, :edit, food)
    assert html_response(conn, 200) =~ "Edit food"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    food = Repo.insert! %Food{}
    conn = put conn, food_path(conn, :update, food), food: @valid_attrs
    assert redirected_to(conn) == food_path(conn, :show, food)
    assert Repo.get_by(Food, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    food = Repo.insert! %Food{}
    conn = put conn, food_path(conn, :update, food), food: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit food"
  end

  test "deletes chosen resource", %{conn: conn} do
    food = Repo.insert! %Food{}
    conn = delete conn, food_path(conn, :delete, food)
    assert redirected_to(conn) == food_path(conn, :index)
    refute Repo.get(Food, food.id)
  end
end
