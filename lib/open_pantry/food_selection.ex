defmodule OpenPantry.FoodSelection do
  @moduledoc """
  The boundary for the FoodSelection system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias OpenPantry.Repo
  alias Ecto.Multi
  alias OpenPantry.StockDistribution
  alias OpenPantry.FoodSelection.Stock
  alias OpenPantry.FoodSelection.CreditType
  alias OpenPantry.UserCredit
  alias OpenPantry.UserOrder
  alias OpenPantry.Facility

  @spec stock_by_type(Facility.t) :: list(tuple())
  def stock_by_type(facility = %Facility{id: id}) do # way more data than needed, but one query! :-/
    now = DateTime.utc_now
    from(credit_type in CreditType,
    join: stocks in assoc(credit_type, :stocks),
    where: stocks.arrival < ^now,
    where: stocks.expiration > ^now,
    where: ^id == stocks.facility_id,
    order_by: credit_type.inserted_at,
    preload: [stocks: [food: :food_group]])
    |> Repo.all
    |> Enum.map(&({&1.name, &1.id, &1.stocks}))
    |> Enum.uniq
    |> append_meals_if_any(facility)
  end

  def play() do # way more data than needed, but one query! :-/
    id = 1
    now = DateTime.utc_now
    from(credit_type in CreditType,
    join: stocks in assoc(credit_type, :stocks),
    where: stocks.arrival < ^now,
    where: stocks.expiration > ^now,
    where: ^id == stocks.facility_id,
    order_by: credit_type.inserted_at,
    preload: [stocks: [food: :food_group]])
    |> Repo.all
  end

  @spec append_meals_if_any(list(tuple()), Facility.t) :: list(tuple())
  def append_meals_if_any(food_stocks, facility) do
    meal_stocks = meal_stocks(facility)
    food_stocks ++  if Enum.any?(meal_stocks) do
                      [{"Meals", :meals, meal_stocks}]
                    else
                      []
                    end
  end

  @spec meal_stocks(Facility.t) :: list(Stock.t)
  def meal_stocks(%Facility{id: id}) do
    now = DateTime.utc_now
    from(stocks in Stock,
    where: stocks.arrival < ^now,
    where: stocks.expiration > ^now,
    where: ^id == stocks.facility_id,
    where: fragment("? IS NOT NULL", stocks.meal_id),
    preload: [:meal])
    |> Repo.all
  end

  @spec adjust_stock(integer(), integer(), integer(), integer() ) :: StockDistribution.t
  def adjust_stock(stock_id, type_id, quantity, user_id) do
    stock = Stock.find(stock_id)
    package = UserOrder.find_current(user_id)
    stock_distribution = StockDistribution.find_or_create(package.id, stock.id)
    cost = stock.credits_per_package
    Multi.new
    |> Multi.update_all(:stock_distribution, StockDistribution.query(stock_distribution.id), [inc: [quantity: quantity]])
    |> Multi.update_all(:stock, Stock.query(stock.id), [inc: [quantity: -quantity]])
    |> deduct_credits(cost, quantity, type_id, user_id, {stock.meal_id, stock.offer_id, stock.food_id })
    |> Repo.transaction
    stock_distribution
  end

  @spec deduct_credits(Ecto.Multi.t, integer(), integer(), integer(), integer(), tuple() ) :: Ecto.Multi.t
  def deduct_credits(multi, cost, quantity, type_id, user_id, {nil, nil, _food_id}) do
    Multi.update_all(multi, type_id, UserCredit.query_user_type(user_id, type_id), [inc: [balance: -(cost*quantity)]])
  end
  def deduct_credits(multi, _cost, _quantity, _type_id, _user_id, {nil, _offer_id, nil}), do: multi
  def deduct_credits(multi, cost, quantity, _type_id, user_id, {_meal_id, nil, nil}) do
    from(c in CreditType, select: c.id)
    |> Repo.all
    |> Enum.reduce(multi, fn(credit_type_id, multi_accum) -> # deduct credits once for each food type, using above clause
        deduct_credits(multi_accum, cost, quantity, credit_type_id, user_id, {nil, nil, credit_type_id})
    end)
  end

end
