defmodule OpenPantry.FoodHandoffControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.FoodHandoff
  @valid_attrs %{finalized: true, ready_for_pickup: true}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, food_handoff_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing food handoffs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, food_handoff_path(conn, :new)
    assert html_response(conn, 200) =~ "New food handoff"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, food_handoff_path(conn, :create), food_handoff: @valid_attrs
    assert redirected_to(conn) == food_handoff_path(conn, :index)
    assert Repo.get_by(FoodHandoff, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, food_handoff_path(conn, :create), food_handoff: @invalid_attrs
    assert html_response(conn, 200) =~ "New food handoff"
  end

  test "shows chosen resource", %{conn: conn} do
    food_handoff = Repo.insert! %FoodHandoff{}
    conn = get conn, food_handoff_path(conn, :show, food_handoff)
    assert html_response(conn, 200) =~ "Show food handoff"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, food_handoff_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    food_handoff = Repo.insert! %FoodHandoff{}
    conn = get conn, food_handoff_path(conn, :edit, food_handoff)
    assert html_response(conn, 200) =~ "Edit food handoff"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    food_handoff = Repo.insert! %FoodHandoff{}
    conn = put conn, food_handoff_path(conn, :update, food_handoff), food_handoff: @valid_attrs
    assert redirected_to(conn) == food_handoff_path(conn, :show, food_handoff)
    assert Repo.get_by(FoodHandoff, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    food_handoff = Repo.insert! %FoodHandoff{}
    conn = put conn, food_handoff_path(conn, :update, food_handoff), food_handoff: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit food handoff"
  end

  test "deletes chosen resource", %{conn: conn} do
    food_handoff = Repo.insert! %FoodHandoff{}
    conn = delete conn, food_handoff_path(conn, :delete, food_handoff)
    assert redirected_to(conn) == food_handoff_path(conn, :index)
    refute Repo.get(FoodHandoff, food_handoff.id)
  end
end
