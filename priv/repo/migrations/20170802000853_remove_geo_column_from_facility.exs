defmodule OpenPantry.Repo.Migrations.RemoveGeoColumnFromFacility do
  use Ecto.Migration

  def down do
    execute "CREATE EXTENSION IF EXISTS postgis"
    execute "CREATE EXTENSION IF EXISTS postgis_topology"
    execute "CREATE EXTENSION IF EXISTS postgis_tiger_geocoder"
    alter table(:facilities) do
      add :location, :geometry
    end
  end

  def change do
    alter table(:facilities) do
      remove :location
    end
    execute "DROP EXTENSION IF EXISTS postgis_tiger_geocoder"
    execute "DROP EXTENSION IF EXISTS postgis_topology"
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end
