defmodule OpenPantry.Repo.Migrations.AddWeightToStocks do
  use Ecto.Migration

  def change do
    alter table(:stocks) do
      add :weight, :decimal
    end
  end
end
