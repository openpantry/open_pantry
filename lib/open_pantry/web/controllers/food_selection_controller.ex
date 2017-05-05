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
                                distributions: distributions,
                                user_order: UserOrder.changeset(user_order)
  end
  def update(conn, params) do
    conn.assigns.user
    |> UserOrder.find_current
    |> UserOrder.changeset(permitted_params(params))
    |> Repo.update
    |> handle_result(conn)
  end

  defp handle_result({:ok, _}, conn) do
    conn
    |> put_flash(:info, gettext("Your order has been finalized!"))
    |> redirect(to: "/#{conn.assigns.locale || "en" }/")
  end

  defp handle_result({:error, changeset}, conn) do
    conn
    |> put_flash(:error, gettext("There was an error updating your order"))
    |> redirect(to: food_selection_path(conn, :index, @conn.assigns.locale))
  end

  defp permitted_params(params) do
    %{finalized: !!params["user_order"]["finalized"]}
  end
end
