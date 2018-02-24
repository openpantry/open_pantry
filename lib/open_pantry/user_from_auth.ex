defmodule OpenPantry.UserFromAuth do
  alias OpenPantry.User
  alias OpenPantry.Repo
  import Ecto.Query, only: [from: 2]

  def get(auth) do
    user =
      from(u in User, where: u.email == ^auth.info.email, preload: [:managed_facilities])
      |> Repo.one
    case user do
      nil -> {:error, :not_found}
      %User{hashed_password: nil} -> {:error, :no_password}
      user ->
        case auth.credentials.other.password do
          pass when is_binary(pass) ->
            if Comeonin.Bcrypt.checkpw(auth.credentials.other.password, user.hashed_password) do
              user
            else
              {:error, :password_does_not_match}
            end
          _ -> {:error, :password_required}
        end
    end
  end
end
