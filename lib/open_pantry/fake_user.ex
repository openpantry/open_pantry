defmodule FakeUser do
  def init(opts), do: opts
  import Plug.Conn
  def call(conn, _opts) do
    # temp/test as if logged in with first user
    assign(conn, :user, OpenPantry.User |> OpenPantry.Repo.all |> List.first)
  end
end