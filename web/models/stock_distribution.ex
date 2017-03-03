defmodule OpenPantry.StockDistribution do
  use OpenPantry.Web, :model
  alias OpenPantry.UserOrder
  alias OpenPantry.Stock
  alias OpenPantry.UserCredit
  alias OpenPantry.CreditType
  alias Ecto.Multi

  schema "stock_distributions" do
    field :quantity, :integer
    belongs_to :stock, Stock
    belongs_to :user_order, UserOrder

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity, :stock_id, :user_order_id])
    |> validate_required([:quantity, :stock_id, :user_order_id])
    |> unique_constraint(:unique_stock_per_package, name: :unique_stock_per_package)
    |> check_constraint(:quantity, name: :non_negative_quantity)
  end

  @spec adjust_stock(integer(), integer(), integer(), integer() ) :: StockDistribution.t
  def adjust_stock(stock_id, type_id, quantity, user_id) do
    stock = Stock.find(stock_id)
    package = UserOrder.find_current(user_id)
    stock_distribution = find_or_create(package.id, stock.id)
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

  @spec package(integer()) :: UserOrder.t
  def package(user_id) do
    UserOrder.query(user_id) |> Repo.one!
  end

  @spec find_or_create(integer(), integer()) :: StockDistribution.t
  def find_or_create(user_order_id, stock_id) do
    find_by_package_and_stock(user_order_id, stock_id) ||
    %StockDistribution{ user_order_id: user_order_id,
                        stock_id: stock_id, quantity: 0}
    |> Repo.insert!()
  end

  @spec query_by_package_and_stock(integer(), integer()) :: Ecto.Query.t
  def query_by_package_and_stock(package_id, stock_id) do
    from(sd in StockDistribution,
    where: sd.user_order_id == ^package_id,
    where: sd.stock_id == ^stock_id)
  end

  @spec find_by_package_and_stock(integer(), integer()) :: StockDistribution.t
  def find_by_package_and_stock(package_id, stock_id) do
    query_by_package_and_stock(package_id, stock_id)
    |> Repo.one
  end

end
