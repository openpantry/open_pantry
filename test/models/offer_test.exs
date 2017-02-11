defmodule OpenPantry.OfferTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Offer

  @valid_attrs %{description: "some content", max_per_package: 42, max_per_person: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Offer.changeset(%Offer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Offer.changeset(%Offer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
