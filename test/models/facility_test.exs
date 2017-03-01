defmodule OpenPantry.FacilityTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Facility

  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = Facility.changeset(%Facility{}, @invalid_attrs)
    refute changeset.valid?
  end
end
