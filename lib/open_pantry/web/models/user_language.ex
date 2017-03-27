defmodule OpenPantry.UserLanguage do
  use OpenPantry.Web, :model

  schema "user_languages" do
    field :fluent, :boolean, default: false
    belongs_to :user, OpenPantry.User
    belongs_to :language, OpenPantry.Language

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:fluent, :user_id, :language_id])
    |> validate_required([:fluent, :user_id, :language_id])
  end
end
