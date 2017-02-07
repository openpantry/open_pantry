defmodule OpenPantry.Repo.Migrations.CreateFoodGroup do
  use Ecto.Migration

  def change do
    create table(:food_groups) do
      add :name, :string
      add :monthly_credits, :integer

      timestamps()
    end

  end
end
