defmodule OpenPantry.Food do
  use OpenPantry.Web, :model

  @primary_key {:ndb_no, :string, []}
  @derive {Phoenix.Param, key: :ndb_no}

  schema "foods" do
    field :longdesc, :string, null: false
    field :shortdesc, :string, null: false
    field :common_name, :string
    field :manufacturer_name, :string
    field :survey, :string
    field :refuse_description, :string
    field :refuse, :decimal
    field :scientific_name, :string
    field :n_factor, :decimal
    field :pro_factor, :decimal
    field :fat_factor, :decimal
    field :cho_factor, :decimal
    belongs_to :food_group, OpenPantry.FoodGroup, references: :foodgroup_code, foreign_key: :foodgroup_code, type: :string
    has_many :credit_types, through: [:food_group, :credit_types]
    has_many :stocks, OpenPantry.Stock, foreign_key: :food_id
    has_many :facilities, through: [:stocks, :facility]
    has_many :users, through: [:facilities, :user]
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [ :ndb_no,
                      :foodgroup_code,
                      :longdesc,
                      :shortdesc,
                      :common_name,
                      :manufacturer_name,
                      :survey,
                      :refuse_description,
                      :refuse,
                      :scientific_name,
                      :n_factor,
                      :pro_factor,
                      :fat_factor,
                      :cho_factor
                    ])
    |> validate_required([:longdesc, :shortdesc, :foodgroup_code])
    |> foreign_key_constraint(:foodgroup_code)
  end

  @spec find(binary()) :: Food.t | nil
  def find(id) when is_binary(id), do:  query(id) |> Repo.one!

  @spec find(binary(), list(atom())) :: Food.t | nil
  def find(id, preload) when is_binary(id) do
    query(id, preload) |> Repo.one!
  end

  @spec query(binary(), list(atom())) :: Ecto.Query.t
  def query(id, preload) when is_binary(id) do
    from(struct in __MODULE__,
    where: struct.ndb_no == ^id,
    preload: ^preload)
  end
  @spec query(binary()) :: Ecto.Query.t
  def query(id) when is_binary(id) do
    from(struct in __MODULE__,
    where: struct.ndb_no == ^id)
  end

end
