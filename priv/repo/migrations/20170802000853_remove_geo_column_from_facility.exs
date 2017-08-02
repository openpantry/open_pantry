defmodule OpenPantry.Repo.Migrations.RemoveGeoColumnFromFacility do
  use Ecto.Migration

  def down do
    execute "CREATE EXTENSION IF EXISTS postgis"
    alter table(:facilities) do
      add :location, :geometry
    end
  end

  def change do
    alter table(:facilities) do
      remove :location
    end
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
