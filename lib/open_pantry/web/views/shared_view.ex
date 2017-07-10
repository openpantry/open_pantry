defmodule OpenPantry.Web.SharedView do
  use OpenPantry.Web, :view
  import OpenPantry.Stock
  import OpenPantry.Web.DisplayLogic
  alias OpenPantry.StockDistribution
  alias OpenPantry.UserOrder
  alias OpenPantry.Image

  @doc """
    Renders a distribution line item for food selection index, or to send update to same page via channel
  """
  def render_distribution(%StockDistribution{id: id}) do
    render_to_string(__MODULE__, "distribution.html", distribution: StockDistribution.find(id, [:stock]))
  end

  @doc """
    Renders a line for user order management index, or to send update to same page via channel
  """
  def render_order_link(user_order = %UserOrder{id: _id}, conn) do
    render_to_string(__MODULE__, "user_order_details.html", order: user_order, conn: conn)
  end

  def image_url(stock) do
    Image.url({:stock_image, stock}, :thumb)
  end

  def max_allowed(stock, family_members) do
    max_family =  if stock.max_per_person do
                    stock.max_per_person * family_members
                  else
                    nil
                  end
    stock.max_per_package || max_family || stock.quantity
  end

end
