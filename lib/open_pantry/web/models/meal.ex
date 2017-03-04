defmodule OpenPantry.Meal do
  use OpenPantry.Web, :model

  schema "meals" do
    field :name, :string
    field :entree, :string
    field :side_dish1, :string
    field :side_dish2, :string
    field :dessert, :string
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
    field :weight, :decimal
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :entree, :side_dish1, :side_dish2, :dessert, :calories, :calories_from_fat, :calcium, :sodium, :cholesterol, :carbohydrate, :sugars, :fat, :saturated_fat, :protein, :fiber, :weight, :description])
    |> validate_required([:name, :description])
  end
end
