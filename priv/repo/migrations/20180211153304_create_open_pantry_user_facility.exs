defmodule OpenPantry.Repo.Migrations.CreateOpenPantry.OpenPantry.UserFacility do
  use Ecto.Migration
  import Ecto.Query
  alias OpenPantry.UserFacility

  def up do
    create table(:user_facilities) do
      add :user_id, references(:users, on_delete: :nothing)
      add :facility_id, references(:facilities, on_delete: :nothing)

      timestamps()
    end

    create index(:user_facilities, [:user_id])
    create index(:user_facilities, [:facility_id])

    flush

    now = DateTime.utc_now
    uf =
      from(u in "users", select: [u.id, u.facility_id])
      |> OpenPantry.Repo.all
      |> Enum.map(fn [u,f] ->
           %{user_id: u, facility_id: f, inserted_at: now, updated_at: now}
         end)
    OpenPantry.Repo.insert_all(UserFacility, uf)

    alter table(:users) do
      remove :facility_id
    end
  end

  def down do
    alter table(:users) do
      add :facility_id, references(:facilities, on_delete: :nothing)
    end

    flush

    for uf <- OpenPantry.Repo.all(UserFacility) do
      from(u in "users",
        update: [set: [facility_id: ^uf.facility_id]],
        where: u.id == ^uf.user_id)
      |> OpenPantry.Repo.update_all([])
    end

    drop table(:user_facilities)
  end
end
