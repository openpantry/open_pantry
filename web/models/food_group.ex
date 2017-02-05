defmodule OpenPantry.FoodGroup do
  use OpenPantry.Web, :model

  schema "food_groups" do
    field :name, :string
    field :exclusive, :boolean, default: false
    field :daily_servings, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :exclusive, :daily_servings])
    |> validate_required([:name, :exclusive, :daily_servings])
  end
end
