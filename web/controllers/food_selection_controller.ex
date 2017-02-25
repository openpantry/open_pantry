defmodule OpenPantry.FoodSelectionController do
  use OpenPantry.Web, :controller
  alias OpenPantry.User
  alias OpenPantry.Facility
  alias OpenPantry.UserFoodPackage
  require IEx
  def index(conn, _params) do
    user = conn.assigns.user |> Repo.preload(:facility)
    stock_by_type = Facility.stock_by_type(user.facility)
    package = UserFoodPackage.find_or_create(user) |> Repo.preload(:stock_distributions)
    distributions = package.stock_distributions |> Repo.preload(:stock)
    render conn, "index.html",  stock_by_type: stock_by_type,
                                credits: User.credits(user),
                                package: package,
                                distributions: distributions
  end
end
