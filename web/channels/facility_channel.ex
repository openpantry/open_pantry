defmodule OpenPantry.FacilityChannel do
  use OpenPantry.Web, :channel
  alias OpenPantry.StockDistribution
  alias OpenPantry.Stock
  alias OpenPantry.User


  def join("facility:" <> facility_id_string, _, socket) do
    facility_id = String.to_integer(facility_id_string)
    socket = Phoenix.Socket.assign(socket, :facility_id, facility_id)
    {:ok, socket}
  end

  def handle_in("request_stock", %{"id" => stock_id, "quantity" => quantity, "type" => type_id}, socket) do
    spawn fn -> # DB constraint may error, don't take down channel with it
      StockDistribution.adjust_stock(stock_id, type_id, quantity, socket.assigns.user_id)
      set_stock(stock_id, socket)
    end
    {:noreply, socket}
  end

  def handle_in("release_stock", %{"id" => stock_id, "quantity" => quantity, "type" => type_id}, socket) do
    spawn fn -> # ditto, pending possible link or change to use changeset but Multi.update vs Multi.update_all
      StockDistribution.adjust_stock(stock_id, type_id, -quantity, socket.assigns.user_id)
      set_stock(stock_id, socket)
    end
    {:noreply, socket}
  end

  defp set_stock(stock_id, socket) do
    broadcast! socket, "set_stock", %{"id" => stock_id, "quantity" => Stock.find(stock_id).quantity}
    push socket, "current_credits", User.credits(socket.assigns.user_id)
  end

end
