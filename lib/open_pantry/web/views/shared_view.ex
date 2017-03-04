defmodule OpenPantry.Web.SharedView do
  use OpenPantry.Web, :view
  import OpenPantry.Stock
  import OpenPantry.Web.DisplayLogic
  alias OpenPantry.StockDistribution

  def render_distribution(%StockDistribution{id: id}) do
    render_to_string(__MODULE__, "distribution.html", distribution: StockDistribution.find(id, [:stock]))
  end

end
