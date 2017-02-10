defmodule OpenPantry.FoodGroup do
  use OpenPantry.Web, :model

  schema "food_groups" do
    field :name, :string
    field :monthly_credits, :integer
    many_to_many :foods, OpenPantry.Food, join_through: "food_group_memberships"
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :monthly_credits])
    |> validate_required([:name, :monthly_credits])
  end
end
