defmodule OpenPantry.FoodSelection.FoodGroup do
  use Ecto.Schema
  import Ecto
  import Ecto.{Query, Changeset}, warn: false
  alias OpenPantry.FoodSelection.Food
  alias OpenPantry.FoodSelection.CreditType

  @primary_key {:foodgroup_code, :string, []}
  @derive {Phoenix.Param, key: :foodgroup_code}

  schema "food_groups" do
    field :foodgroup_desc, :string
    has_many :foods, Food, foreign_key: :foodgroup_code
    many_to_many :credit_types, CreditType, join_through: "credit_type_memberships", join_keys: [food_group_id: :foodgroup_code, credit_type_id: :id]
  end

end
