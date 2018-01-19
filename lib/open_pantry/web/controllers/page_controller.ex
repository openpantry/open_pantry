defmodule OpenPantry.Web.PageController do
  use OpenPantry.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", languages: OpenPantry.Language.primary_list, landing_page: true
  end
end
