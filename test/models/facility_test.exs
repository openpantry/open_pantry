defmodule OpenPantry.FacilityTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Facility

  @valid_attrs %{address1: "some content", address2: "some content", city: "some content", location: "some content", max_occupancy: 42, name: "some content", postal_code: "some content", region: "some content", square_meterage_storage: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Facility.changeset(%Facility{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Facility.changeset(%Facility{}, @invalid_attrs)
    refute changeset.valid?
  end
end
