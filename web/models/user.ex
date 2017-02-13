defmodule OpenPantry.User do
  use OpenPantry.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    coherence_schema()
    field :phone, :string
    field :ok_to_text, :boolean, default: false
    field :family_members, :integer
    field :credits, :map
    belongs_to :facility, OpenPantry.Facility
    has_many :foods, through: [:facility, :food]
    many_to_many :languages, OpenPantry.Language, join_through: "user_languages"
    has_many :user_food_packages, OpenPantry.UserFoodPackage
    has_many :stock_distributions, through: [:user_food_packages, :stock_distributions]
    belongs_to :primary_language, OpenPantry.Language
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name, :phone, :ok_to_text, :family_members, :credits, :primary_language_id, :facility_id] ++ coherence_fields())
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_required([:name, :family_members, :primary_language_id, :facility_id])
    |> validate_coherence(params)
  end
end
