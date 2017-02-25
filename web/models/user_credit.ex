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
    |> check_constraint(:balance, name: :non_negative_balance)
  end

  def query_user_type(user_id, type_id) do
    from(uc in UserCredit,
    where: uc.user_id == ^user_id,
    where: uc.credit_type_id == ^type_id)
  end

end
