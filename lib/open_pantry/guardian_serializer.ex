defmodule OpenPantry.GuardianSerializer do
  @behaviour Guardian.Serializer

  require Ecto.Query

  alias OpenPantry.Repo
  alias OpenPantry.User

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, User |> Ecto.Query.preload(:managed_facilities) |> Repo.get(id) }
  def from_token(_), do: { :error, "Unknown resource type" }
end
