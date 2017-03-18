defmodule OpenPantry.Web.FoodSelectionController do
  use OpenPantry.Web, :controller
  alias OpenPantry.User
  alias OpenPantry.UserOrder
  alias OpenPantry.FoodSelection
  require IEx
  def index(conn, _params) do
    user = conn.assigns.user |> Repo.preload(:facility)
    stock_by_type = FoodSelection.stock_by_type(user.facility)
    user_order = UserOrder.find_or_create(user) |> Repo.preload(:stock_distributions)
    distributions = user_order.stock_distributions
                    |> Repo.preload(:stock)
                    |> Enum.reject(&(&1.quantity == 0))
    render conn, "index.html",  stock_by_type: stock_by_type,
                                credits: User.credits(user),
                                package: user_order,
                                distributions: distributions
  end
end
