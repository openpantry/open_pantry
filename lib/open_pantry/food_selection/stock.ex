defmodule OpenPantry.FoodSelection.Stock do
  use Ecto.Schema
  import Ecto.Query
  use OpenPantry.SharedRepo
  alias OpenPantry.Repo
  alias OpenPantry.FoodSelection.Food
  alias OpenPantry.Meal
  alias OpenPantry.Offer
  alias OpenPantry.Facility
  alias OpenPantry.StockDistribution
  schema "stocks" do
    field :quantity, :integer
    field :arrival, Ecto.DateTime
    field :expiration, Ecto.DateTime
    field :packaging, :string
    field :credits_per_package, :integer
    field :weight, :decimal
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

end
