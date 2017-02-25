defmodule OpenPantry.Repo.Migrations.RemoveNotNullTimestampsFromCreditTypeMemberships do
  use Ecto.Migration

  def up do
    alter table(:credit_type_memberships) do
      modify :inserted_at, :utc_datetime, null: true
      modify :updated_at, :utc_datetime, null: true
    end
  end

  def down do
    alter table(:credit_type_memberships) do
      modify :inserted_at, :utc_datetime, null: false
      modify :updated_at, :utc_datetime, null: false
    end
  end

end
