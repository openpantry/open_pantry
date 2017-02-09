defmodule OpenPantry.Repo.Migrations.CreateUserFoodPackage do
  use Ecto.Migration

  def change do
    create table(:user_food_packages) do
      add :ready_for_pickup, :boolean, default: false, null: false
      add :finalized, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:user_food_packages, [:user_id])

  end
end
