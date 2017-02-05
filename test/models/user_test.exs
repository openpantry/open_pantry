defmodule OpenPantry.UserTest do
  use OpenPantry.ModelCase

  alias OpenPantry.User

  @valid_attrs %{carb_credits: 42, email: "some content", family_members: 42, name: "some content", ok_to_text: true, phone: "some content", protein_credits: 42, veggie_credits: 42}
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
