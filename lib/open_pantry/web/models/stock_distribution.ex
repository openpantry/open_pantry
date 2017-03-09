defmodule OpenPantry.StockDistribution do
  use OpenPantry.Web, :model
  alias OpenPantry.UserOrder
  alias OpenPantry.Stock

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
