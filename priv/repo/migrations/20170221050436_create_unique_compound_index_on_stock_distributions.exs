defmodule OpenPantry.Repo.Migrations.CreateUniqueCompoundIndexOnStockDistributions do
  use Ecto.Migration

  def change do
    drop index(:stock_distributions, [:stock_id])
    drop index(:stock_distributions, [:user_food_package_id])
    create index(:stock_distributions, [:user_food_package_id, :stock_id], unique: true, name: :unique_stock_per_package)
  end
end
