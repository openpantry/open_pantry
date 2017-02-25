defmodule OpenPantry.CreditTypeMembership do
  use OpenPantry.Web, :model

  schema "credit_type_memberships" do
    belongs_to :food_group, OpenPantry.FoodGroup, references: :foodgroup_code, type: :string
    belongs_to :credit_type, OpenPantry.CreditType
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
