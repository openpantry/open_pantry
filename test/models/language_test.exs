defmodule OpenPantry.LanguageTest do
  use OpenPantry.ModelCase

  alias OpenPantry.Language

  @valid_attrs %{english_name: "some content", iso_code: "some content", native_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Language.changeset(%Language{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Language.changeset(%Language{}, @invalid_attrs)
    refute changeset.valid?
  end
end
