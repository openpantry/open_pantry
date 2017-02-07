defmodule OpenPantry.FoodGroup do
  use OpenPantry.Web, :model

  schema "food_groups" do
    field :name, :string
    field :monthly_credits, :integer
    has_many :food_group_memberships, OpenPantry.FoodGroupMembership, on_delete: :delete_all
    has_many :foods, through: [:food_group_memberships, :foods]

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
