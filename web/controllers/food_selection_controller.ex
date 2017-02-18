defmodule OpenPantry.FoodSelectionController do
  use OpenPantry.Web, :controller
  alias OpenPantry.User
  alias OpenPantry.Facility
  require IEx
  def index(conn, _params) do
    user = conn.assigns.user |> Repo.preload(:facility)
    food_stock_by_type = Facility.food_stock_by_credit_type(user.facility)
    render conn, "index.html", food_stock_by_type: food_stock_by_type, credits: User.credits(user)
  end
end
