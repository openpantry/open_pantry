defmodule OpenPantry.Repo.Migrations.CreateUserLanguage do
  use Ecto.Migration

  def change do
    create table(:user_languages) do
      add :fluent, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :language_id, references(:languages, on_delete: :nothing)

      timestamps()
    end
    create index(:user_languages, [:user_id])
    create index(:user_languages, [:language_id])

  end
end
