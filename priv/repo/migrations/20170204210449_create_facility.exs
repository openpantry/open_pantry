defmodule OpenPantry.Repo.Migrations.CreateFacility do
  use Ecto.Migration

  def change do
    create table(:facilities) do
      add :name, :string
      add :location, :geometry
      add :address1, :string
      add :address2, :string
      add :city, :string
      add :region, :string
      add :postal_code, :string
      add :max_occupancy, :integer
      add :square_meterage_storage, :float

      timestamps()
    end
    create unique_index(:facilities, [:name])

  end
end
