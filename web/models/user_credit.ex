defmodule OpenPantry.UserCredit do
  use OpenPantry.Web, :model

  schema "user_credits" do
    field :balance, :integer
    belongs_to :user, OpenPantry.User
    belongs_to :credit_type, OpenPantry.CreditType

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:balance])
    |> validate_required([:balance])
  end
end
