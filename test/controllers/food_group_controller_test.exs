defmodule OpenPantry.FoodGroupControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.FoodGroup
  @valid_attrs %{monthly_credits: 42, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, food_group_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing food groups"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, food_group_path(conn, :new)
    assert html_response(conn, 200) =~ "New food group"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, food_group_path(conn, :create), food_group: @valid_attrs
    assert redirected_to(conn) == food_group_path(conn, :index)
    assert Repo.get_by(FoodGroup, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, food_group_path(conn, :create), food_group: @invalid_attrs
    assert html_response(conn, 200) =~ "New food group"
  end

  test "shows chosen resource", %{conn: conn} do
    food_group = Repo.insert! %FoodGroup{}
    conn = get conn, food_group_path(conn, :show, food_group)
    assert html_response(conn, 200) =~ "Show food group"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, food_group_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    food_group = Repo.insert! %FoodGroup{}
    conn = get conn, food_group_path(conn, :edit, food_group)
    assert html_response(conn, 200) =~ "Edit food group"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    food_group = Repo.insert! %FoodGroup{}
    conn = put conn, food_group_path(conn, :update, food_group), food_group: @valid_attrs
    assert redirected_to(conn) == food_group_path(conn, :show, food_group)
    assert Repo.get_by(FoodGroup, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    food_group = Repo.insert! %FoodGroup{}
    conn = put conn, food_group_path(conn, :update, food_group), food_group: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit food group"
  end

  test "deletes chosen resource", %{conn: conn} do
    food_group = Repo.insert! %FoodGroup{}
    conn = delete conn, food_group_path(conn, :delete, food_group)
    assert redirected_to(conn) == food_group_path(conn, :index)
    refute Repo.get(FoodGroup, food_group.id)
  end
end
