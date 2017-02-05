defmodule OpenPantry.StockControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.Stock
  @valid_attrs %{arrival: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, expiration: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, quantity: 42, reorder_quantity: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stock_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing stocks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, stock_path(conn, :new)
    assert html_response(conn, 200) =~ "New stock"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, stock_path(conn, :create), stock: @valid_attrs
    assert redirected_to(conn) == stock_path(conn, :index)
    assert Repo.get_by(Stock, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stock_path(conn, :create), stock: @invalid_attrs
    assert html_response(conn, 200) =~ "New stock"
  end

  test "shows chosen resource", %{conn: conn} do
    stock = Repo.insert! %Stock{}
    conn = get conn, stock_path(conn, :show, stock)
    assert html_response(conn, 200) =~ "Show stock"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, stock_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    stock = Repo.insert! %Stock{}
    conn = get conn, stock_path(conn, :edit, stock)
    assert html_response(conn, 200) =~ "Edit stock"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    stock = Repo.insert! %Stock{}
    conn = put conn, stock_path(conn, :update, stock), stock: @valid_attrs
    assert redirected_to(conn) == stock_path(conn, :show, stock)
    assert Repo.get_by(Stock, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    stock = Repo.insert! %Stock{}
    conn = put conn, stock_path(conn, :update, stock), stock: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit stock"
  end

  test "deletes chosen resource", %{conn: conn} do
    stock = Repo.insert! %Stock{}
    conn = delete conn, stock_path(conn, :delete, stock)
    assert redirected_to(conn) == stock_path(conn, :index)
    refute Repo.get(Stock, stock.id)
  end
end
