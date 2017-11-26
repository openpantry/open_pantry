defmodule OpenPantry.Repo.Migrations.AddHashedPasswordField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :hashed_password, :string
    end
  end
end
