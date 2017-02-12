defmodule OpenPantry.Repo.Migrations.CreateFoodGroup do
  use Ecto.Migration

  def change do
    create table(:food_groups, primary_key: false) do
      add :foodgroup_code, :string, primary_key: true
      add :foodgroup_desc, :string
    end

  end
end
