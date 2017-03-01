defmodule OpenPantry.UserOrderTest do
  use OpenPantry.ModelCase

  alias OpenPantry.UserOrder

  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = UserOrder.changeset(%UserOrder{}, @invalid_attrs)
    refute changeset.valid?
  end
end
