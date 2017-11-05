defmodule OpenPantry.StockDistribution do
  use OpenPantry.Web, :model
  alias OpenPantry.UserOrder
  alias OpenPantry.User
  alias OpenPantry.Stock

  schema "stock_distributions" do
    field :quantity, :integer
    belongs_to :stock, Stock
    belongs_to :user_order, UserOrder
    has_one :user, through: [:user_order, :user]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity, :stock_id, :user_order_id])
    |> validate_required([:quantity, :stock_id, :user_order_id])
    |> validate_max_per_order
    |> unique_constraint(:unique_stock_per_package, name: :unique_stock_per_package)
    |> check_constraint(:quantity, name: :non_negative_quantity)
  end

  def validate_max_per_order(changeset, options \\ []) do
    # we validate the quantity from the changeset, not this arg
    validate_change(changeset, :quantity, fn _, _quantity ->

      case validate_stock_distribution(%{}, changeset.data) do
        {:ok, _} ->
          []
        {:error, _} ->
          [{:quantity, options[:message] || "Over max allowed quantity per person or per order"}]
      end
    end)
  end

  def validate_stock_distribution(map, stock_distribution, quantity \\ nil) do
    new_quantity =
      if quantity == nil do
        stock_distribution.quantity
      else
        stock_distribution.quantity + quantity
      end
    if quantity < 1 || per_person_ok?(stock_distribution, new_quantity) && per_package_ok?(stock_distribution, new_quantity) do
      {:ok, map}
    else
      {:error, map}
    end
  end

  defp per_person_ok?(%StockDistribution{ stock: %Stock{ max_per_person: nil } }, _quantity), do: true
  defp per_person_ok?(stock_distribution, quantity) do
    if User.is_guest(stock_distribution.user) do
      quantity <= stock_distribution.stock.max_per_person
    else
      quantity <= stock_distribution.stock.max_per_person * stock_distribution.user.family_members
    end
  end

  defp per_package_ok?(%StockDistribution{ stock: %Stock{ max_per_package: nil } }, _quantity), do: true
  defp per_package_ok?(stock_distribution, quantity) do
    quantity <= stock_distribution.stock.max_per_package
  end

  @spec package(integer()) :: UserOrder.t
  def package(user_id) do
    UserOrder.query(user_id) |> Repo.one!
  end

  @spec find_or_create(integer(), integer()) :: StockDistribution.t
  def find_or_create(user_order_id, stock_id) do
    exisiting_distribution = find_by_package_and_stock(user_order_id, stock_id, [:user, :stock])
    if exisiting_distribution do
      exisiting_distribution
    else
      stock = Stock.find(stock_id)
      user = UserOrder.find(user_order_id, [:user]).user
      %StockDistribution{ user_order_id: user_order_id,
                          stock_id: stock_id, quantity: 0, user: user, stock: stock}
      |> Repo.insert!()
    end
  end

  @spec query_by_package_and_stock(integer(), integer()) :: Ecto.Query.t
  def query_by_package_and_stock(package_id, stock_id, preload \\ []) do
    from(sd in StockDistribution,
    where: sd.user_order_id == ^package_id,
    where: sd.stock_id == ^stock_id,
    preload: ^preload)
  end

  @spec find_by_package_and_stock(integer(), integer()) :: StockDistribution.t
  def find_by_package_and_stock(package_id, stock_id, preload \\ []) do
    query_by_package_and_stock(package_id, stock_id, preload)
    |> Repo.one
  end

  def total_weight(%StockDistribution{stock: stock, quantity: quantity}) do
    stock.weight && Decimal.mult(stock.weight, Decimal.new(quantity))
  end

end
