defmodule OpenPantry.StockDistribution do
  use OpenPantry.Web, :model

  schema "stock_distributions" do
    field :quantity, :integer
    belongs_to :stock, OpenPantry.Stock
    belongs_to :user_food_package, OpenPantry.UserFoodPackage

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity, :stock_id, :user_food_package_id])
    |> validate_required([:quantity, :stock_id, :user_food_package_id])
  end
end
