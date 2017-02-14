defmodule OpenPantry.Repo.Migrations.CreateUserCredit do
  use Ecto.Migration

  def up do
    create table(:user_credits) do
      add :balance, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :credit_type_id, references(:credit_types, on_delete: :nothing)

      timestamps()
    end
    alter table(:users) do
      remove :credits
    end
    create index(:user_credits, [:user_id])
    create index(:user_credits, [:credit_type_id])
  end

  def down do
    drop table(:user_credits)
    alter table(:users) do
      add :credits, :map
    end
  end
end
