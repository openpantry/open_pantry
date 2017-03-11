defmodule OpenPantry.FoodSelection.Food do
  use Ecto.Schema

  import Ecto
  import Ecto.{Query, Changeset}, warn: false
  alias OpenPantry.FoodSelection.Stock
  use OpenPantry.SharedRepo
  @primary_key {:ndb_no, :string, []}
  @derive {Phoenix.Param, key: :ndb_no}

  schema "foods" do
    field :longdesc, :string, null: false
    field :manufacturer_name, :string
    belongs_to :food_group, OpenPantry.FoodGroup, references: :foodgroup_code, foreign_key: :foodgroup_code, type: :string
    has_many :credit_types, through: [:food_group, :credit_types]
    has_many :stocks, Stock, foreign_key: :food_id
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
