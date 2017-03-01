defmodule OpenPantry.UserLanguageTest do
  use OpenPantry.ModelCase

  alias OpenPantry.UserLanguage

  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = UserLanguage.changeset(%UserLanguage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
