defmodule OpenPantry.UserFromAuth do
  alias OpenPantry.User
  alias OpenPantry.Repo

  def get(auth) do
    case Repo.get_by(User, email: auth.info.email) do
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
