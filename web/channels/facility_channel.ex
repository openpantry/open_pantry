defmodule OpenPantry.FacilityChannel do
  use OpenPantry.Web, :channel
  alias OpenPantry.Presence
  alias OpenPantry.Facility


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
    push socket, "stocks", %{ stocks: serialize(socket.assigns.stocks) }
    {:noreply, socket}
  end

  def handle_in("request_stock", payload, socket) do
    # broadcast! socket, "request_stock", payload
    require IEx
    IEx.pry
    {:noreply, socket}
  end

  def handle_in("release_stock", payload, socket) do
    # broadcast! socket, "release_stock", payload
    require IEx
    IEx.pry
    {:noreply, socket}
  end

  def handle_in("add_stock", payload, socket) do
    # broadcast! socket, "add_stock", payload
    require IEx
    IEx.pry
    {:noreply, socket}
  end

  def handle_in("remove_stock", payload, socket) do
    # broadcast! socket, "remove_stock", payload
    require IEx
    IEx.pry
    {:noreply, socket}
  end

  defp serialize(stocks) do
    Enum.map(stocks, &( [&1.id, &1.quantity] ))
  end
end
