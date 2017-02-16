defmodule OpenPantry.Facility do
  use OpenPantry.Web, :model

  alias OpenPantry.Stock
  schema "facilities" do
    field :name, :string
    field :location, Geo.Point
    field :address1, :string
    field :address2, :string
    field :city, :string
    field :region, :string
    field :postal_code, :string
    field :max_occupancy, :integer
    field :square_meterage_storage, :float
    has_many :users, OpenPantry.User, on_delete: :nilify_all
    has_many :stocks, OpenPantry.Stock, on_delete: :delete_all
    has_many :foods, through: [:stocks, :food]
    has_many :food_groups, through: [:foods, :food_group]
    has_many :credit_types, through: [:food_groups, :credit_types]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :location, :address1, :address2, :city, :region, :postal_code, :max_occupancy, :square_meterage_storage])
    |> unique_constraint(:name)
    |> validate_required([:name])
  end


  def food_stock_by_credit_type(facility = %Facility{id: id}) do
    now = DateTime.utc_now
    from stock in Stock,
    join: credit_types in assoc(stock, :credit_types),
    where: stock.arrival < ^now,
    where: stock.expiration > ^now,
    where: ^id == stock.facility_id,
    preload: [credit_types: credit_types]
  end

end
