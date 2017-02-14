defmodule OpenPantry.CreditType do
  use OpenPantry.Web, :model

  schema "credit_types" do
    field :name, :string
    field :credits_per_period, :integer
    field :period_name, :string
    many_to_many :food_groups, OpenPantry.FoodGroup, join_through: "credit_type_memberships", join_keys: [credit_type_id: :id, food_group_id: :foodgroup_code]


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :credits_per_period, :period_name])
    |> validate_required([:name, :credits_per_period, :period_name])
  end
end
