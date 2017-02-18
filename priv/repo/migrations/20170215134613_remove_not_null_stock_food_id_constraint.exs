defmodule OpenPantry.Repo.Migrations.RemoveNotNullStockFoodIdConstraint do
  use Ecto.Migration

  def up do
    alter table(:stocks) do
      modify :food_id, :string, null: true
    end
  end

  def down do
  end
end
