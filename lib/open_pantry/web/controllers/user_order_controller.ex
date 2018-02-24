defmodule OpenPantry.Web.UserOrderController do
  use OpenPantry.Web, :controller

  require Ecto.Query

  alias Ecto.Query
  alias OpenPantry.User
  alias OpenPantry.UserOrder

  def index(conn, params) do
    orders =
      UserOrder
      |> Query.preload(:user)
      |> filter_facility(conn)
      |> orders_for_params(params)
      |> Repo.all
    conn
    |> setup_channel_credentials(params)
    |> render("index.html", orders: orders, conn: conn)
  end

  def show(conn, %{"id" => id}) do
    order =
      UserOrder
      |> Query.preload([:user, :stock_distributions, :stocks, :foods, :meals, :offers])
      |> filter_facility(conn)
      |> Repo.get!(id)
    render(conn, "show.html", order: order)
  end

  defp orders_for_params(query, %{"all" => _}) do
    query
  end

  defp orders_for_params(query, %{"ready" => _}) do
    query |> Query.where(ready_for_pickup: true)
  end

  defp orders_for_params(query, _) do
    query |> Query.where(finalized: true) |> Query.where(ready_for_pickup: false)
  end

  defp filter_facility(query, conn) do
    user = Guardian.Plug.current_resource(conn)
    case user do
      %User{role: :superadmin} ->
        query
      %User{role: :admin, managed_facilities: facilities} when length(facilities) > 0 ->
        Query.from q in query, join: u in assoc(q, :user), where: u.facility_id in ^Enum.map(facilities, &(&1.id))
      _ ->
        Query.from q in query, join: u in assoc(q, :user), where: is_nil(u.facility_id)
    end
  end

  # Temporary hack while hardcoding to facility 1, but needs some kind of user token for websocket auth
  defp setup_channel_credentials(conn, _params) do
    conn
    |> assign(:user_token, Phoenix.Token.sign(conn, "user socket", 1))
  end
end
