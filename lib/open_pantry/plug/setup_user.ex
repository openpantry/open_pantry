defmodule OpenPantry.Plug.SetupUser do
  alias OpenPantry.User
  alias OpenPantry.Repo
  def init(opts), do: opts
  import Plug.Conn
  require IEx

  def call(conn, opts) do
    conn
    |> assign_user_from_cookie
    |> put_user_token_and_facility
    |> redirect_unless_user_present(Map.new(opts))
  end

  defp assign_user_from_cookie(conn) do
    user = User.query(user_cookie(conn))
           |> Repo.one
    assign(conn, :user, user)
  end

  defp put_user_token_and_facility(conn) do
    if current_user = conn.assigns[:user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      conn
      |> assign(:user_token, token)
      |> assign(:facility_id, current_user.facility_id)
    else
      conn
    end
  end

  defp redirect_unless_user_present(conn, opts) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: opts.redirect_url)
      |> halt
    end
  end

  defp user_cookie(conn) do
    user_id = conn.cookies["user_id"]
    if Blank.blank?(user_id) do
      0 # safe value, will not find user in query but will not error
    else
      String.to_integer(user_id)
    end

  end

end