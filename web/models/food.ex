defmodule OpenPantry.Food do
  use OpenPantry.Web, :model

  schema "foods" do
    field :name, :string
    field :serving_size, :decimal
    field :calories, :integer
    field :calories_from_fat, :integer
    field :calcium, :integer
    field :sodium, :integer
    field :cholesterol, :integer
    field :carbohydrate, :integer
    field :sugars, :integer
    field :fat, :integer
    field :saturated_fat, :integer
    field :protein, :integer
    field :fiber, :integer
    field :description, :string
    has_many :stocks, OpenPantry.Stock
    has_many :facilities, through: [:stocks, :facility]
    has_many :users, through: [:facilities, :user]
    has_many :food_group_memberships, OpenPantry.FoodGroupMembership
    has_many :food_groups, through: [:food_group_memberships, :food_group]


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :calories, :calories_from_fat, :description] ++ mg_columns() ++ gram_columns() ++ kg_columns() )
    |> validate_required([:name, :serving_size])
  end

  def mg_columns do
    [:sodium, :cholesterol, :calcium]
  end

  def gram_columns do
    [:fat, :saturated_fat, :protein, :fiber, :sugars, :carbohydrate]
  end

  def kg_columns do
    [:serving_size]
  end
end
