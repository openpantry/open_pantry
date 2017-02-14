defmodule OpenPantry.Repo.Migrations.CreateCreditTypeMembership do
  use Ecto.Migration

  def change do
    create table(:credit_type_memberships) do
      add :food_group_id, references(:food_groups, on_delete: :nothing, column: :foodgroup_code, type: :string), null: false
      add :credit_type_id, references(:credit_types, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:credit_type_memberships, [:food_group_id])
    create index(:credit_type_memberships, [:credit_type_id])

  end
end
