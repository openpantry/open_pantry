defmodule OpenPantry.Web.UserSelectionView do
  use OpenPantry.Web, :view

  def login_token(user) do
    expiry  =  Timex.now
            |> Timex.add( Timex.Duration.from_days(1))
            |> Timex.to_unix
    {:ok, token, _claim} = Guardian.encode_and_sign(user, :access, %{exp: expiry })
    token
  end

end
