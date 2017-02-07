defmodule OpenPantry.Repo.Migrations.CreateFoodHandoff do
  use Ecto.Migration

  def change do
    create table(:food_handoffs) do
      add :ready_for_pickup, :boolean, default: false, null: false
      add :finalized, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:food_handoffs, [:user_id])

  end
end
