defmodule OpenPantry.Repo.Migrations.CreateFoodGroupMembership do
  use Ecto.Migration

  def change do
    create table(:food_group_memberships) do
      add :proportion, :decimal
      add :quantity, :integer
      add :food_id, references(:foods, on_delete: :nothing)
      add :food_group_id, references(:food_groups, on_delete: :nothing)

      timestamps()
    end
    create index(:food_group_memberships, [:food_id])
    create index(:food_group_memberships, [:food_group_id])

  end
end
