defmodule OpenPantry.FoodGroupMembershipControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.FoodGroupMembership
  @valid_attrs %{proportion: "120.5", quantity: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, food_group_membership_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing food group memberships"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, food_group_membership_path(conn, :new)
    assert html_response(conn, 200) =~ "New food group membership"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, food_group_membership_path(conn, :create), food_group_membership: @valid_attrs
    assert redirected_to(conn) == food_group_membership_path(conn, :index)
    assert Repo.get_by(FoodGroupMembership, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, food_group_membership_path(conn, :create), food_group_membership: @invalid_attrs
    assert html_response(conn, 200) =~ "New food group membership"
  end

  test "shows chosen resource", %{conn: conn} do
    food_group_membership = Repo.insert! %FoodGroupMembership{}
    conn = get conn, food_group_membership_path(conn, :show, food_group_membership)
    assert html_response(conn, 200) =~ "Show food group membership"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, food_group_membership_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    food_group_membership = Repo.insert! %FoodGroupMembership{}
    conn = get conn, food_group_membership_path(conn, :edit, food_group_membership)
    assert html_response(conn, 200) =~ "Edit food group membership"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    food_group_membership = Repo.insert! %FoodGroupMembership{}
    conn = put conn, food_group_membership_path(conn, :update, food_group_membership), food_group_membership: @valid_attrs
    assert redirected_to(conn) == food_group_membership_path(conn, :show, food_group_membership)
    assert Repo.get_by(FoodGroupMembership, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    food_group_membership = Repo.insert! %FoodGroupMembership{}
    conn = put conn, food_group_membership_path(conn, :update, food_group_membership), food_group_membership: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit food group membership"
  end

  test "deletes chosen resource", %{conn: conn} do
    food_group_membership = Repo.insert! %FoodGroupMembership{}
    conn = delete conn, food_group_membership_path(conn, :delete, food_group_membership)
    assert redirected_to(conn) == food_group_membership_path(conn, :index)
    refute Repo.get(FoodGroupMembership, food_group_membership.id)
  end
end
