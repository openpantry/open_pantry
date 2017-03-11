defmodule OpenPantry.Stock do
  use OpenPantry.Web, :model
  alias OpenPantry.Repo
  alias OpenPantry.Food
  alias OpenPantry.FoodSelection
  alias OpenPantry.Meal
  alias OpenPantry.Offer
  alias OpenPantry.Facility
  alias OpenPantry.StockDistribution
  schema "stocks" do
    field :quantity, :integer
    field :arrival, Ecto.DateTime
    field :expiration, Ecto.DateTime
    field :reorder_quantity, :integer
    field :weight, :decimal
    field :aisle, :string
    field :row, :string
    field :shelf, :string
    field :packaging, :string
    field :credits_per_package, :integer
    belongs_to :food, Food, references: :ndb_no, type: :string
    belongs_to :meal, Meal
    belongs_to :offer, Offer
    belongs_to :facility, Facility
    has_one :food_group, through: [:food, :food_group]
    has_many :credit_types, through: [:food_group, :credit_types]
    has_many :stock_distributions, StockDistribution
    has_many :user_orders, through: [:stock_distributions, :user_order]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity, :arrival, :expiration, :reorder_quantity, :aisle, :row, :shelf, :packaging, :credits_per_package, :food_id, :meal_id, :offer_id, :facility_id])
    |> validate_required([:quantity, :facility_id])
    |> validate_stockable
    |> check_constraint(:quantity, name: :non_negative_quantity)
  end

  @spec stockable!(Stock.t) :: Meal.t | Food.t | Offer.t
  def stockable!(stock) do
    stock.food || stock.meal || stock.offer
  end

  @spec stock_description(Stock.t) :: String.t
  def stock_description(stock) do
    loaded_stock = stockable_load(stock)
    (loaded_stock.food && loaded_stock.food.longdesc)    ||
    (loaded_stock.meal && loaded_stock.meal.description) ||
    (loaded_stock.offer && loaded_stock.offer.description)
  end

  @spec stockable(Stock.t) :: Stock.t
  def stockable(stock) do
    stock
    |> stockable_load
    |> stockable!
  end

  @spec stockable_name(Stock.t) :: String.t
  def stockable_name(stock) do
    item = stockable(stock)
    case item.__struct__ do
      OpenPantry.Food -> item.longdesc
      _ -> item.name
    end
  end

  @spec stockable_load(Stock.t) :: Stock.t
  def stockable_load(stock) do
    stock
    |> Repo.preload(:food)
    |> Repo.preload(:meal)
    |> Repo.preload(:offer)
  end

  def validate_stockable(changeset) do
    [get_field(changeset, :food_id), get_field(changeset, :meal_id), get_field(changeset, :offer_id)]
    |> Enum.reject(&is_nil/1)
    |> length
    |> handle_stockable_error(changeset)
  end

  def handle_stockable_error(1, changeset), do: changeset
  def handle_stockable_error(0, changeset), do: add_error(changeset, :food_id, "A stock item must stock a food, meal or offer")
  def handle_stockable_error(_, changeset), do: add_error(changeset, :meal_id, "A stock item must stock only one food, meal or offer")


end
