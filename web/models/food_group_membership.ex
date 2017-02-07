defmodule OpenPantry.FoodGroupMembership do
  use OpenPantry.Web, :model

  schema "food_group_memberships" do
    belongs_to :food, OpenPantry.Food
    belongs_to :food_group, OpenPantry.FoodGroup

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:food_group_id, :food_id])
    |> validate_required([:food_group_id, :food_id])
  end
end
