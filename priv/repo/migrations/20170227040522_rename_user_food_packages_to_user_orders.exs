defmodule OpenPantry.Repo.Migrations.RenameUserFoodPackagesToUserOrders do
  use Ecto.Migration

  def change do
    rename table(:user_food_packages), to: table(:user_orders)
    drop index(:stock_distributions, [:user_food_package_id, :stock_id], unique: true, name: :unique_stock_per_package)
    rename table(:stock_distributions), :user_food_package_id, to: :user_order_id
    create index(:stock_distributions, [:user_order_id, :stock_id], unique: true, name: :unique_stock_per_package)
  end
end
