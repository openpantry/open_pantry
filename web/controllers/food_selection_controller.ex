defmodule OpenPantry.FoodSelectionController do
  use OpenPantry.Web, :controller
  alias OpenPantry.User
  require IEx
  def index(conn, _params) do
    user = conn.assigns.user
    stock_by_type = User.stock_by_type(user)
    render conn, "index.html", stock_by_type: stock_by_type, credits: User.credits(user)
  end
end
