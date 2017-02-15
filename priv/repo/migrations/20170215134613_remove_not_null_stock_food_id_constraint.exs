defmodule OpenPantry.Repo.Migrations.RemoveNotNullStockFoodIdConstraint do
  use Ecto.Migration

  def change do
    alter table(:stocks) do
      modify :food_id, :string, null: true
    end
  end
end
