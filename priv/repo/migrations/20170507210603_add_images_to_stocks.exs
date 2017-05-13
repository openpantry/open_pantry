defmodule OpenPantry.Repo.Migrations.AddImagesToStocks do
  use Ecto.Migration

  def change do
    alter table(:stocks) do
      add :image, :string
    end
  end
end
