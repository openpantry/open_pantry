defmodule OpenPantry.UserOrder do
  use OpenPantry.Web, :model
  alias OpenPantry.User

  schema "user_orders" do
    field :ready_for_pickup, :boolean, default: false
    field :finalized, :boolean, default: false
    belongs_to :user, OpenPantry.User
    has_many :stock_distributions, OpenPantry.StockDistribution, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:ready_for_pickup, :finalized, :user_id])
    |> validate_required([:ready_for_pickup, :finalized, :user_id])
  end

  def find_or_create(user = %User{id: id}) do
    find_current(user) || %UserOrder{user_id: id} |> Repo.insert!()
  end

  def query(id, preload  \\ []) when is_integer(id) do
    from(package in UserOrder,
    where: package.finalized == false,
    where: package.user_id == ^id,
    preload: ^preload)
  end

  def find_current(%User{id: id}), do: find_current(id)
  def find_current(id) when is_integer(id) do
    query(id)
    |> Repo.one
  end


end
