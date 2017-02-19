defmodule OpenPantry.UserFoodPackage do
  use OpenPantry.Web, :model
  alias OpenPantry.User
  schema "user_food_packages" do
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
    from(package in UserFoodPackage,
    where: package.finalized == false,
    where: package.user_id == ^id)
    |> Repo.one || %UserFoodPackage{user_id: id} |> Repo.insert!()
  end

end
