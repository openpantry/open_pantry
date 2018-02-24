defmodule OpenPantry.UserManagedFacility do
  use Ecto.Schema
  import Ecto.Changeset
  alias OpenPantry.UserManagedFacility

  schema "user_managed_facilities" do
    belongs_to :user, OpenPantry.User
    belongs_to :facility, OpenPantry.Facility

    timestamps()
  end

  @doc false
  def changeset(%UserManagedFacility{} = user_facility, attrs) do
    user_facility
    |> cast(attrs, [:user_id, :facility_id])
    |> validate_required([:user_id, :facility_id])
  end
end
