defmodule OpenPantry.Web.SessionController do
  use OpenPantry.Web, :controller

  def delete(conn, _params) do
    conn
    |> clear_session
    |> Plug.Conn.delete_resp_cookie("user_token")
    |> redirect(to: "/en")
  end

end