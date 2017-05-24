defmodule OpenPantry.Repo.Migrations.AddOverrideTextToStocks do
  use Ecto.Migration

  def change do
    alter table(:stocks) do
      add :override_text, :string
    end
  end
end
