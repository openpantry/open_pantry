defmodule OpenPantry.FoodSelection.CreditType do
  import Ecto.{Query, Changeset}, warn: false
  use Ecto.Schema
  use OpenPantry.SharedRepo
  alias OpenPantry.FoodSelection.FoodGroup
  schema "credit_types" do
    field :name, :string
    field :credits_per_period, :integer
    field :period_name, :string
    many_to_many :food_groups, FoodGroup, join_through: "credit_type_memberships", join_keys: [credit_type_id: :id, food_group_id: :foodgroup_code]
    has_many :foods, through: [:food_groups, :foods]
    has_many :stocks, through: [:foods, :stocks]
    has_many :facilities, through: [:stocks, :facility]

    timestamps()
  end
end

