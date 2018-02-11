defmodule OpenPantry.UserFacility do
  use Ecto.Schema
  import Ecto.Changeset
  alias OpenPantry.UserFacility

  schema "user_facilities" do
    belongs_to :user, OpenPantry.User
    belongs_to :facility, OpenPantry.Facility

    timestamps()
  end

  @doc false
  def changeset(%UserFacility{} = user_facility, attrs) do
    user_facility
    |> cast(attrs, [:user_id, :facility_id])
    |> validate_required([:user_id, :facility_id])
  end
end
