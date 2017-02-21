defmodule OpenPantry.FacilityChannel do
  use OpenPantry.Web, :channel
  alias OpenPantry.Presence
  alias OpenPantry.Facility
  alias OpenPantry.StockDistribution


  def join("facility:" <> facility_id_string, _, socket) do
    facility_id = String.to_integer(facility_id_string)
    query = from facility in Facility, where: facility.id == ^facility_id, preload: :stocks
    facility = Repo.one(query)
    stocks = facility.stocks
    socket = Phoenix.Socket.assign(socket, :stocks, stocks)
    socket = Phoenix.Socket.assign(socket, :facility_id, facility_id)

    send self(), :after_join
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    join_metadata = %{ online_at: :os.system_time(:milli_seconds) }
    # Presence.track(socket, socket.assigns.user_id, join_metadata)

    # push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_in("request_stock", %{"id" => stock_id, "quantity" => quantity, "type" => type_id}, socket) do
    updated_stocks = StockDistribution.adjust_stock(stock_id, type_id, quantity, socket.assigns.user_id)
    # update_client_stocks(updated_stocks, socket, "remove_stock")
    # push socket, "stocks", %{ stocks: serialize(updated_stocks) }
    {:noreply, socket}
  end

  def handle_in("release_stock", %{"id" => stock_id, "quantity" => quantity, "type" => type_id}, socket) do
    updated_stocks = StockDistribution.adjust_stock(stock_id, type_id, -quantity, socket.assigns.user_id)
    # update_client_stocks(updated_stocks, socket, "add_stock")
    # push socket, "stocks", %{ stocks: serialize(updated_stocks) }
    {:noreply, socket}
  end

  # def handle_out("add_stock", %{"id" => stock_id, "quantity" => quantity}, socket) do
  #   # broadcast! socket, "add_stock", payload
  #   {:noreply, socket}
  # end

  # def handle_out("remove_stock", %{"id" => stock_id, "quantity" => quantity}, socket) do
  #   # broadcast! socket, "remove_stock", payload
  #   {:noreply, socket}
  # end

  defp update_client_stocks({:ok, stocks}, socket, action) do
    broadcast! socket, action, serialize({:ok, stocks})
  end

  defp update_client_stocks({:error, _stocks}, action), do: nil

  defp serialize({_status, stocks}) do
    Enum.map(stocks, &( [&1.id, &1.quantity] ))
  end
end
