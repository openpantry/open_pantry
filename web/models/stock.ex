defmodule OpenPantry.Stock do
  use OpenPantry.Web, :model

  schema "stocks" do
    field :quantity, :integer
    field :arrival, Ecto.DateTime
    field :expiration, Ecto.DateTime
    field :reorder_quantity, :integer
    field :aisle, :string
    field :row, :string
    field :shelf, :string
    field :packaging, :string
    field :credits_per_package, :integer
    belongs_to :food, OpenPantry.Food
    belongs_to :facility, OpenPantry.Facility
    has_many :food_groups, through: [:food, :food_groups]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity, :arrival, :expiration, :reorder_quantity, :aisle, :row, :shelf, :packaging, :credits_per_package, :food_id, :facility_id])
    |> validate_required([:quantity, :food_id, :facility_id])
  end
end
