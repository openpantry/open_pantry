defmodule OpenPantry.Repo.Migrations.CreateLanguage do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :iso_code, :string
      add :english_name, :string
      add :native_name, :string

      timestamps()
    end
    create unique_index(:languages, [:iso_code])

  end
end
