defmodule OpenPantry.Web.RegistrationController do
  use OpenPantry.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
