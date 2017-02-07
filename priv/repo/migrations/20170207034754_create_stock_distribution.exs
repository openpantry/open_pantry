defmodule OpenPantry.Repo.Migrations.CreateStockDistribution do
  use Ecto.Migration

  def change do
    create table(:stock_distributions) do
      add :quantity, :integer
      add :stock_id, references(:stocks, on_delete: :nothing)
      add :food_handoff_id, references(:food_handoffs, on_delete: :nothing)

      timestamps()
    end
    create index(:stock_distributions, [:stock_id])
    create index(:stock_distributions, [:food_handoff_id])

  end
end
