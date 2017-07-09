defmodule OpenPantry.UpdateCredits do
  alias OpenPantry.UserCredit
  alias OpenPantry.CreditType
  alias OpenPantry.User
  alias OpenPantry.Repo
  import Ecto.Query, only: [from: 2]
  defp process_user(user, credit_types) do
    user_id = user.id
    for credit_type <- credit_types do
      credit_type_id = credit_type.id
      user_credit = from(user_credit in UserCredit,
                    where: user_credit.user_id == ^user_id,
                    where: user_credit.credit_type_id == ^credit_type_id)
                    |> Repo.one!

      start_balance = credit_type.credits_per_period * user.family_members

      if user_credit.balance < start_balance do
        new_balance = if System.get_env("ROLLOVER_CREDITS") do
                        start_balance + user_credit.balance
                      else
                        start_balance
                      end
        UserCredit.changeset(user_credit, %{balance: new_balance })
        |> Repo.update!()
      end
    end

  end

  def renew_all() do
    credit_types  = CreditType |> Repo.all
    users         = User       |> Repo.all
    for user <- users do
      process_user(user, credit_types)
    end
  end

  def biweekly_renewal() do
    {_year, week, weekday} = Timex.now |> Timex.iso_triplet
    odd_week = rem(week, 2) == 1
    saturday = weekday == 7
    if saturday && odd_week do
      renew_all()
    end
  end
end