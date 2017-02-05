defmodule OpenPantry.Repo.Migrations.CreateFoodGroup do
  use Ecto.Migration

  def change do
    create table(:food_groups) do
      add :name, :string
      add :exclusive, :boolean, default: false, null: false
      add :daily_servings, :integer

      timestamps()
    end

  end
end
