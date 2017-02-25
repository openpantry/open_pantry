defmodule OpenPantry.Repo.Migrations.RemoveNotNullTimestampsFromCreditTypeMemberships do
  use Ecto.Migration

  def change do
    alter table(:credit_type_memberships) do
      modify :inserted_at, :utc_datetime, null: true
      modify :updated_at, :utc_datetime, null: true
    end
  end
end
