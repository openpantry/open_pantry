defmodule OpenPantry.Repo.Migrations.CreateFood do
  use Ecto.Migration
  alias OpenPantry.Food

  def change do
    create table(:foods, primary_key: false) do
      add :ndb_no, :string, primary_key: true
      add :foodgroup_code, references(:food_groups, on_delete: :nothing, column: :foodgroup_code, type: :string), null: false
      add :longdesc, :string, null: false
      add :shortdesc, :string, null: false
      add :common_name, :string
      add :manufacturer_name, :string
      add :survey, :string
      add :refuse_description, :string
      add :refuse, :decimal
      add :scientific_name, :string
      add :n_factor, :decimal
      add :pro_factor, :decimal
      add :fat_factor, :decimal
      add :cho_factor, :decimal
    end
  end

end
