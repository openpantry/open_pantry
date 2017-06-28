defmodule OpenPantry.Web.UserOrderController do
  use OpenPantry.Web, :controller

  alias OpenPantry.UserOrder

  def index(conn, params) do
    conn
    |> setup_channel_credentials(params)
    |> render("index.html", orders: orders_for_params(params), conn: conn)
  end

  def show(conn, %{"id" => id}) do
    order = UserOrder.find(String.to_integer(id), [:user, :stock_distributions, :stocks, :foods, :meals, :offers] )
    render(conn, "show.html", order: order)
  end

  defp orders_for_params(%{"all" => _}) do
    UserOrder.all(:user)
  end

  defp orders_for_params(%{"ready" => _}) do
    UserOrder.all(:user)
    |> Enum.filter(&(&1.ready_for_pickup))
  end

  defp orders_for_params(_) do
    UserOrder.all(:user)
    |> Enum.filter(&(&1.finalized && !&1.ready_for_pickup))
  end


  @doc """
    Temporary hack while hardcoding to facility 1, but needs some kind of user token for websocket auth
  """
  defp setup_channel_credentials(conn, _params) do
    conn
    |> assign(:user_token, Phoenix.Token.sign(conn, "user socket", 1))
  end
end
