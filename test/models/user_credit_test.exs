defmodule OpenPantry.UserCreditTest do
  use OpenPantry.ModelCase

  alias OpenPantry.UserCredit

  @valid_attrs %{balance: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserCredit.changeset(%UserCredit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserCredit.changeset(%UserCredit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
