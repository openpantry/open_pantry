defmodule OpenPantry.CreditTypeTest do
  use OpenPantry.ModelCase

  alias OpenPantry.CreditType

  @valid_attrs %{credits_per_period: 42, name: "some content", period_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CreditType.changeset(%CreditType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CreditType.changeset(%CreditType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
