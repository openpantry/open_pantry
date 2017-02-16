defmodule OpenPantry.FoodGroup do
  use OpenPantry.Web, :model

  @primary_key {:foodgroup_code, :string, []}
  @derive {Phoenix.Param, key: :foodgroup_code}

  schema "food_groups" do
    field :foodgroup_desc, :string
    has_many :foods, OpenPantry.Food, foreign_key: :ndb_no
    many_to_many :credit_types, OpenPantry.CreditType, join_through: "credit_type_memberships", join_keys: [food_group_id: :foodgroup_code, credit_type_id: :id]
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :foodgroup_code,
                      :foodgroup_desc
                    ])
    |> validate_required([:foodgroup_code, :foodgroup_desc])
  end

end
