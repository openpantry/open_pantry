defmodule OpenPantry.User do
  use OpenPantry.Web, :model
  alias OpenPantry.Stock
  schema "users" do
    field :email, :string
    field :name, :string
    field :phone, :string
    field :ok_to_text, :boolean, default: false
    field :family_members, :integer
    belongs_to :facility, OpenPantry.Facility
    has_many :foods, through: [:facility, :food]
    many_to_many :languages, OpenPantry.Language, join_through: "user_languages"
    has_many :user_orders, OpenPantry.UserOrder
    has_many :stock_distributions, through: [:user_orders, :stock_distributions]
    belongs_to :primary_language, OpenPantry.Language
    has_many :user_credits, OpenPantry.UserCredit
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name, :phone, :ok_to_text, :family_members, :primary_language_id, :facility_id])
    |> unique_constraint(:email)
    |> validate_required([:name, :family_members, :primary_language_id, :facility_id])
  end

  def credits(user_id) when is_integer(user_id), do: find(user_id) |> credits

  def credits(user) do
    credits = Repo.preload(user, :user_credits).user_credits
    |> Repo.preload(:credit_type)
    food_credits = Enum.map(credits, fn credit ->
      {credit.credit_type.name, credit.balance}
    end)
    |> Map.new
    Map.put(food_credits, "Meals", meal_points(food_credits))
  end

  def meal_points(map) do
    Map.values(map)
    |> Enum.min
  end

  def facility_stocks(user) do
    Repo.preload(user, :facility).facility
    |> Repo.preload(:stocks)
    |> (&(&1.stocks)).()
    |> Enum.map(&Stock.stockable/1)
  end

end
