defmodule OpenPantry.Repo.Migrations.AddRolesToUsers do
  use Ecto.Migration

  def up do
    UserRoleEnum.create_type
    alter table(:users) do
      add :role, :role
    end
  end

  def down do
    alter table(:users) do
      remove :role
    end
    UserRoleEnum.drop_type
  end
end
