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
    has_many :user_food_packages, OpenPantry.UserFoodPackage
    has_many :stock_distributions, through: [:user_food_packages, :stock_distributions]
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

  def credits(user) do
    Repo.preload(user, :user_credits).user_credits
    |> Repo.preload(:credit_type)
  end

  def stock_by_type(user) do
    facility_stocks(user)
    |> Enum.group_by(&(&1.__struct__))
  end


  def facility_stocks(user) do
    Repo.preload(user, :facility).facility
    |> Repo.preload(:stocks)
    |> (&(&1.stocks)).()
    |> Enum.map(&Stock.stockable/1)
  end

end
