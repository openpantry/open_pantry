defmodule OpenPantry.FoodGroup do
  use OpenPantry.Web, :model

  @primary_key {:foodgroup_code, :string, []}
  @derive {Phoenix.Param, key: :foodgroup_code}

  schema "food_groups" do
    field :foodgroup_desc, :string
    has_many :foods, OpenPantry.Food, foreign_key: :foodgroup_code
    many_to_many :credit_types, OpenPantry.CreditType, join_through: "credit_type_memberships", join_keys: [food_group_id: :foodgroup_code, credit_type_id: :id]
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :foodgroup_code,
                      :foodgroup_desc
                    ])
    |> validate_required([:foodgroup_code, :foodgroup_desc])
  end

  @spec find(String.t) :: FoodGroup.t | nil
  def find(id) when is_binary(id), do:  query(id) |> Repo.one!

  @spec find(String.t, nonempty_list()) :: FoodGroup.t | nil
  def find(id, preload) when is_binary(id) do
    query(id, preload) |> Repo.one!
  end

  @spec query(String.t, nonempty_list()) :: Ecto.Query.t
  def query(id, preload) when is_binary(id) do
    from(struct in __MODULE__,
    where: struct.foodgroup_code == ^id,
    preload: ^preload)
  end
  @spec query(String.t) :: Ecto.Query.t
  def query(id) when is_binary(id) do
    from(struct in __MODULE__,
    where: struct.foodgroup_code == ^id)
  end

end
