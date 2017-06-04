defmodule OpenPantry.Web.UserOrderView do
  use OpenPantry.Web, :view
  alias OpenPantry.Web.SharedView

  def image_url(stock) do
    SharedView.image_url(stock)
  end
end
