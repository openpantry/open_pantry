defmodule OpenPantry.UserTest do
  use OpenPantry.ModelCase

  alias OpenPantry.User

  @valid_attrs %{credits: %{}, email: "some content", family_members: 42, name: "some content", ok_to_text: true, phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
