defmodule OpenPantry.Repo.Migrations.AddCoherenceToUser do
  use Ecto.Migration
  def change do
    alter table(:users) do
      # authenticatable
      add :password_hash, :string
      add :admin, :boolean
    end


  end
end
