defmodule OpenPantry.UserTest do
  use OpenPantry.ModelCase

  alias OpenPantry.User

  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
