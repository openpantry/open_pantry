defmodule OpenPantry.Repo.Migrations.MoveMaxLimitsToStock do
  use Ecto.Migration

  def up do
    alter table(:offers) do
      remove :max_per_person
      remove :max_per_package
    end
    alter table(:stocks) do
      add :max_per_person, :integer
      add :max_per_package, :integer
    end
  end

  def down do
    alter table(:stocks) do
      remove :max_per_person
      remove :max_per_package
    end
    alter table(:offers) do
      add :max_per_person, :integer
      add :max_per_package, :integer
    end
  end
end
