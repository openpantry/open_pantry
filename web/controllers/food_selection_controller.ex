defmodule OpenPantry.FoodSelectionController do
  use OpenPantry.Web, :controller
  alias OpenPantry.User
  alias OpenPantry.Facility
  alias OpenPantry.UserFoodPackage
  require IEx
  def index(conn, _params) do
    user = conn.assigns.user |> Repo.preload(:facility)
    food_stock_by_type = Facility.food_stock_by_credit_type(user.facility)
    package = UserFoodPackage.find_or_create(user) |> Repo.preload(:stock_distributions)
    distributions = package.stock_distributions |> Repo.preload(:stock)
    meal_stocks = Facility.meal_stocks(user.facility)
    render conn, "index.html",  food_stock_by_type: food_stock_by_type,
                                credits: User.credits(user),
                                package: package,
                                meal_stocks: meal_stocks,
                                distributions: distributions
  end
end
