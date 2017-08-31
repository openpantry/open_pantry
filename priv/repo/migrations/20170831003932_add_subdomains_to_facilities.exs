defmodule OpenPantry.Repo.Migrations.AddSubdomainsToFacilities do
  use Ecto.Migration

  def change do
    alter table(:facilities) do
      add :subdomain, :string
    end

    create unique_index(:facilities, [:subdomain])
  end
end
