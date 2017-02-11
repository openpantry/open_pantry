defmodule OpenPantry.OfferControllerTest do
  use OpenPantry.ConnCase

  alias OpenPantry.Offer
  @valid_attrs %{description: "some content", max_per_package: 42, max_per_person: 42, name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, offer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing offers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, offer_path(conn, :new)
    assert html_response(conn, 200) =~ "New offer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, offer_path(conn, :create), offer: @valid_attrs
    assert redirected_to(conn) == offer_path(conn, :index)
    assert Repo.get_by(Offer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, offer_path(conn, :create), offer: @invalid_attrs
    assert html_response(conn, 200) =~ "New offer"
  end

  test "shows chosen resource", %{conn: conn} do
    offer = Repo.insert! %Offer{}
    conn = get conn, offer_path(conn, :show, offer)
    assert html_response(conn, 200) =~ "Show offer"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, offer_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    offer = Repo.insert! %Offer{}
    conn = get conn, offer_path(conn, :edit, offer)
    assert html_response(conn, 200) =~ "Edit offer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    offer = Repo.insert! %Offer{}
    conn = put conn, offer_path(conn, :update, offer), offer: @valid_attrs
    assert redirected_to(conn) == offer_path(conn, :show, offer)
    assert Repo.get_by(Offer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    offer = Repo.insert! %Offer{}
    conn = put conn, offer_path(conn, :update, offer), offer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit offer"
  end

  test "deletes chosen resource", %{conn: conn} do
    offer = Repo.insert! %Offer{}
    conn = delete conn, offer_path(conn, :delete, offer)
    assert redirected_to(conn) == offer_path(conn, :index)
    refute Repo.get(Offer, offer.id)
  end
end
