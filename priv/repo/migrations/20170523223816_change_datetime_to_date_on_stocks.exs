defmodule OpenPantry.Repo.Migrations.ChangeDatetimeToDateOnStocks do
  use Ecto.Migration

  def up do
    alter table(:stocks) do
      modify :arrival, :date
      modify :expiration, :date
    end
  end

  def down do
    alter table(:stocks) do
      modify :arrival, :utc_datetime
      modify :expiration, :utc_datetime
    end
  end
end
