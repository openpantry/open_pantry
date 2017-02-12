defmodule OpenPantry.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
      add :entree, :string
      add :side_dish1, :string
      add :side_dish2, :string
      add :dessert, :string
      add :calories, :integer
      add :calories_from_fat, :integer
      add :calcium, :integer
      add :sodium, :integer
      add :cholesterol, :integer
      add :carbohydrate, :integer
      add :sugars, :integer
      add :fat, :integer
      add :saturated_fat, :integer
      add :protein, :integer
      add :fiber, :integer
      add :weight, :decimal
      add :description, :string

      timestamps()
    end

  end
end
