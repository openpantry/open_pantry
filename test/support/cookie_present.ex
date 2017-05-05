defmodule OpenPantry.CookiePresent do
  def init(opts), do: opts
  def call(conn, _opts) do
    user = OpenPantry.User |> OpenPantry.Repo.all |> List.first
    user_id = if user, do: user.id, else: 1
    Plug.Conn.put_resp_cookie(conn, "user_id", Integer.to_string(user_id))
  end
end