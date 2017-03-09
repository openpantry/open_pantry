defmodule OpenPantry.FoodSelection do
  @moduledoc """
  The boundary for the FoodSelection system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias OpenPantry.Repo
  alias Ecto.Multi
  alias OpenPantry.StockDistribution
  alias OpenPantry.Stock
  alias OpenPantry.UserCredit
  alias OpenPantry.UserOrder
  alias OpenPantry.CreditType

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
  def deduct_credits(multi, cost, quantity, type_id, user_id, {nil, nil, food_id}) do
    Multi.update_all(multi, type_id, UserCredit.query_user_type(user_id, type_id), [inc: [balance: -(cost*quantity)]])
  end
  def deduct_credits(multi, cost, quantity, type_id, user_id, {nil, offer_id, nil}), do: multi
  def deduct_credits(multi, cost, quantity, _type_id, user_id, {_meal_id, nil, nil}) do
    from(c in CreditType, select: c.id)
    |> Repo.all
    |> Enum.reduce(multi, fn(credit_type_id, multi_accum) -> # deduct credits once for each food type, using above clause
        deduct_credits(multi_accum, cost, quantity, credit_type_id, user_id, {nil, nil, credit_type_id})
    end)
  end

end
