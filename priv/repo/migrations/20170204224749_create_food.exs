defmodule OpenPantry.Repo.Migrations.CreateFood do
  use Ecto.Migration
  alias OpenPantry.Food

  def change do
    create table(:foods) do
      add :name, :string
      add :serving_size, :decimal
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
      add :description, :string

      timestamps()
    end

    Enum.each(Food.mg_columns(), fn column ->
      execute("
        COMMENT on column foods.#{column} is 'weight in milligrams';
      ")
    end)
    Enum.each(Food.gram_columns(), fn column ->
      execute("
        COMMENT on column foods.#{column} is 'weight in grams';
      ")
    end)
    Enum.each(Food.kg_columns(), fn column ->
      execute("
        COMMENT on column foods.#{column} is 'weight in kilograms';
      ")
    end)

  end
end
