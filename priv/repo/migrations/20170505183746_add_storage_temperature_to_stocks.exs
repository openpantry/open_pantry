defmodule OpenPantry.Repo.Migrations.AddStorageTemperatureToStocks do
  use Ecto.Migration


  def up do
    RefrigerationEnum.create_type
    alter table(:stocks) do
      add :storage, :refrigeration
    end
  end

  def down do
    alter table(:stocks) do
      remove :storage
    end
    RefrigerationEnum.drop_type
  end
end
