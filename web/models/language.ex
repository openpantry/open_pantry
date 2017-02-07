defmodule OpenPantry.Language do
  use OpenPantry.Web, :model

  schema "languages" do
    field :iso_code, :string
    field :english_name, :string
    field :native_name, :string
    has_many :user_languages, OpenPantry.UserLanguage, on_delete: :delete_all
    has_many :users, through: [:user_languages, :user]


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:iso_code, :english_name, :native_name])
    |> unique_constraint(:iso_code)
    |> validate_required([:iso_code, :english_name])
  end
end
