defmodule OpenPantry.StockDistribution do
  use OpenPantry.Web, :model
  alias OpenPantry.UserFoodPackage
  alias OpenPantry.Stock
  alias OpenPantry.UserCredit
  alias Ecto.Multi

  schema "stock_distributions" do
    field :quantity, :integer
    belongs_to :stock, Stock
    belongs_to :user_food_package, UserFoodPackage

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity, :stock_id, :user_food_package_id])
    |> validate_required([:quantity, :stock_id, :user_food_package_id])
    |> unique_constraint(:unique_stock_per_package, name: :unique_stock_per_package)
    |> check_constraint(:quantity, name: :non_negative_quantity)
  end

  def adjust_stock(stock_id, type_id, quantity, user_id) do
    package = UserFoodPackage.find_current(user_id)
    stock_distribution = find_or_create(package.id, stock_id)
    cost = Stock.find(stock_id).credits_per_package
    Multi.new
    |> Multi.update_all(:stock_distribution, StockDistribution.query(stock_distribution), [inc: [quantity: quantity]])
    |> Multi.update_all(:stock, Stock.query(stock_id), [inc: [quantity: -quantity]])
    |> Multi.update_all(:credit, UserCredit.query(user_id, type_id), [inc: [balance: -(cost*quantity)]])
    |> Repo.transaction
  end

  def package(user_id) do
    UserFoodPackage.query(user_id) |> Repo.one!
  end

  def find_or_create(user_food_package_id, stock_id) do
    find(user_food_package_id, stock_id) ||
    %StockDistribution{ user_food_package_id: user_food_package_id,
                        stock_id: stock_id, quantity: 0}
    |> Repo.insert!()
  end

  def query(%StockDistribution{id: id}), do: query(id)

  def query(id) when is_integer(id) do
    from(sd in StockDistribution,
    where: sd.id == ^id)
  end

  def query(package_id, stock_id) do
    from(sd in StockDistribution,
    where: sd.user_food_package_id == ^package_id,
    where: sd.stock_id == ^stock_id)
  end

  def find(package_id, stock_id) do
    query(package_id, stock_id)
    |> Repo.one
  end

end
