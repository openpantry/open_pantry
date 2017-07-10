defmodule OpenPantry.Web.FoodSelectionController do
  use OpenPantry.Web, :controller
  alias OpenPantry.User
  alias OpenPantry.UserOrder
  alias OpenPantry.FoodSelection
  alias OpenPantry.Web.SharedView
  alias OpenPantry.Web.Endpoint
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
  def update(conn, params = %{"id" => id}) do
    UserOrder.find(String.to_integer(id), [:user, [user: :facility]])
    |> UserOrder.changeset(permitted_params(params))
    |> Repo.update
    |> handle_result(conn)
  end

  defp handle_result({:ok, user_order}, conn) do
    facility = user_order.user.facility
    Endpoint.broadcast("facility:#{facility.id}", "order_update", %{"html" => SharedView.render_order_link(user_order, conn)})
    conn
    |> put_flash(:info, gettext("Your order has been finalized!"))
    |> Plug.Conn.delete_resp_cookie("user_token")
    |> redirect(to: "/#{conn.assigns.locale || "en" }/")
  end

  defp handle_result({:error, _changeset}, conn) do
    conn
    |> put_flash(:error, gettext("There was an error updating your order"))
    |> redirect(to: food_selection_path(conn, :index, conn.assigns.locale))
  end

  defp permitted_params(params) do
    %{finalized: !!params["user_order"]["finalized"], ready_for_pickup: !!params["user_order"]["ready_for_pickup"]}
  end
end
