defmodule OpenPantry.FoodGroupMembership do
  use OpenPantry.Web, :model

  schema "food_group_memberships" do
    field :proportion, :decimal
    field :quantity, :integer
    belongs_to :food, OpenPantry.Food
    belongs_to :food_group, OpenPantry.FoodGroup

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:proportion, :quantity])
    |> validate_required([:proportion, :quantity])
  end
end
