defmodule OpenPantry.UserFoodPackageControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.UserFoodPackage
  @valid_attrs %{finalized: true, ready_for_pickup: true}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_food_package_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing user food packages"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_food_package_path(conn, :new)
    assert html_response(conn, 200) =~ "New user food package"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_food_package_path(conn, :create), user_food_package: @valid_attrs
    assert redirected_to(conn) == user_food_package_path(conn, :index)
    assert Repo.get_by(UserFoodPackage, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_food_package_path(conn, :create), user_food_package: @invalid_attrs
    assert html_response(conn, 200) =~ "New user food package"
  end

  test "shows chosen resource", %{conn: conn} do
    user_food_package = Repo.insert! %UserFoodPackage{}
    conn = get conn, user_food_package_path(conn, :show, user_food_package)
    assert html_response(conn, 200) =~ "Show user food package"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_food_package_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user_food_package = Repo.insert! %UserFoodPackage{}
    conn = get conn, user_food_package_path(conn, :edit, user_food_package)
    assert html_response(conn, 200) =~ "Edit user food package"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user_food_package = Repo.insert! %UserFoodPackage{}
    conn = put conn, user_food_package_path(conn, :update, user_food_package), user_food_package: @valid_attrs
    assert redirected_to(conn) == user_food_package_path(conn, :show, user_food_package)
    assert Repo.get_by(UserFoodPackage, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_food_package = Repo.insert! %UserFoodPackage{}
    conn = put conn, user_food_package_path(conn, :update, user_food_package), user_food_package: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user food package"
  end

  test "deletes chosen resource", %{conn: conn} do
    user_food_package = Repo.insert! %UserFoodPackage{}
    conn = delete conn, user_food_package_path(conn, :delete, user_food_package)
    assert redirected_to(conn) == user_food_package_path(conn, :index)
    refute Repo.get(UserFoodPackage, user_food_package.id)
  end
end
