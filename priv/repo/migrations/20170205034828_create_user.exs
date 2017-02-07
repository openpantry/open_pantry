defmodule OpenPantry.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :phone, :string
      add :ok_to_text, :boolean, default: false, null: false
      add :family_members, :integer
      add :credits, :map
      add :facility_id, references(:facilities, on_delete: :nothing)
      add :primary_language_id, references(:languages, on_delete: :nothing)

      timestamps()
    end
    create index(:users, [:facility_id])
    create unique_index(:users, [:email])

  end
end
