defmodule OpenPantry.UserOrderTest do
  use OpenPantry.ModelCase

  alias OpenPantry.UserOrder

  @valid_attrs %{finalized: true, ready_for_pickup: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserOrder.changeset(%UserOrder{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserOrder.changeset(%UserOrder{}, @invalid_attrs)
    refute changeset.valid?
  end
end
