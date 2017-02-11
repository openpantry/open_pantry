defmodule OpenPantry.Repo.Migrations.AddMealIdAndOfferIdToStock do
  use Ecto.Migration

  def change do
    alter table(:stocks) do
      add :meal_id, references(:meals, on_delete: :nothing)
      add :offer_id, references(:offers, on_delete: :nothing)
    end
  end
end
