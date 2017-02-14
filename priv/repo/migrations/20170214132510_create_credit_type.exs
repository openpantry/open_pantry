defmodule OpenPantry.Repo.Migrations.CreateCreditType do
  use Ecto.Migration

  def change do
    create table(:credit_types) do
      add :name, :string
      add :credits_per_period, :integer
      add :period_name, :string

      timestamps()
    end

  end
end
