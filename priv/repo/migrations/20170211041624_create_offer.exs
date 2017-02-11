defmodule OpenPantry.Repo.Migrations.CreateOffer do
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :name, :string
      add :description, :string
      add :max_per_person, :integer
      add :max_per_package, :integer

      timestamps()
    end

  end
end
