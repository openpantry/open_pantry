defmodule OpenPantry.Repo.Migrations.CreateStockDistribution do
  use Ecto.Migration

  def change do
    create table(:stock_distributions) do
      add :quantity, :integer
      add :stock_id, references(:stocks, on_delete: :nothing)
      add :user_food_package_id, references(:user_food_packages, on_delete: :nothing)

      timestamps()
    end
    create index(:stock_distributions, [:stock_id])
    create index(:stock_distributions, [:user_food_package_id])

  end
end
