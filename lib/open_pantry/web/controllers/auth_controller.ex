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
    # TODO : Log out
    conn
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    # TODO : Authenticate
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> redirect(to: "/")
  end
end
