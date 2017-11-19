defmodule OpenPantry.Web.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use OpenPantry.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> render("request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    expiry =
      Timex.now
      |> Timex.add( Timex.Duration.from_days(1))
      |> Timex.to_unix
    path = get_session(conn, :redirect_url) || "/"

    # TODO: really check auth.
    user = OpenPantry.User.guest

    conn
    |> Guardian.Plug.sign_in(user, :admin, %{exp: expiry})
    |> put_flash(:info, "Successfully authenticated.")
    |> redirect(to: path)
  end

  def unauthenticated(conn, params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> put_session(:redirect_url, conn.request_path)
    |> redirect(to: auth_path(conn, :request, "identity"))
  end
end
