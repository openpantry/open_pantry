defmodule OpenPantry.FacilityControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.Facility
  @valid_attrs %{address1: "some content", address2: "some content", city: "some content", location: "some content", max_occupancy: 42, name: "some content", postal_code: "some content", region: "some content", square_meterage_storage: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, facility_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing facilities"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, facility_path(conn, :new)
    assert html_response(conn, 200) =~ "New facility"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, facility_path(conn, :create), facility: @valid_attrs
    assert redirected_to(conn) == facility_path(conn, :index)
    assert Repo.get_by(Facility, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, facility_path(conn, :create), facility: @invalid_attrs
    assert html_response(conn, 200) =~ "New facility"
  end

  test "shows chosen resource", %{conn: conn} do
    facility = Repo.insert! %Facility{}
    conn = get conn, facility_path(conn, :show, facility)
    assert html_response(conn, 200) =~ "Show facility"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, facility_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    facility = Repo.insert! %Facility{}
    conn = get conn, facility_path(conn, :edit, facility)
    assert html_response(conn, 200) =~ "Edit facility"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    facility = Repo.insert! %Facility{}
    conn = put conn, facility_path(conn, :update, facility), facility: @valid_attrs
    assert redirected_to(conn) == facility_path(conn, :show, facility)
    assert Repo.get_by(Facility, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    facility = Repo.insert! %Facility{}
    conn = put conn, facility_path(conn, :update, facility), facility: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit facility"
  end

  test "deletes chosen resource", %{conn: conn} do
    facility = Repo.insert! %Facility{}
    conn = delete conn, facility_path(conn, :delete, facility)
    assert redirected_to(conn) == facility_path(conn, :index)
    refute Repo.get(Facility, facility.id)
  end
end
