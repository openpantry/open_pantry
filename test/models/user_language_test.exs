defmodule OpenPantry.UserLanguageTest do
  use OpenPantry.ModelCase

  alias OpenPantry.UserLanguage

  @valid_attrs %{fluent: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserLanguage.changeset(%UserLanguage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserLanguage.changeset(%UserLanguage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
