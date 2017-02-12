defmodule OpenPantry.FoodGroup do
  use OpenPantry.Web, :model

  @primary_key {:foodgroup_code, :string, []}
  @derive {Phoenix.Param, key: :foodgroup_code}

  schema "food_groups" do
    field :foodgroup_desc, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :foodgroup_code,
                      :foodgroup_desc
                    ])
    |> validate_required([:foodgroup_code, :foodgroup_desc])
  end

end
