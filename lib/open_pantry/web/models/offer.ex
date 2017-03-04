defmodule OpenPantry.Offer do
  use OpenPantry.Web, :model

  schema "offers" do
    field :name, :string
    field :description, :string
    field :max_per_person, :integer
    field :max_per_package, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :max_per_person, :max_per_package])
    |> validate_required([:name, :description])
  end
end
