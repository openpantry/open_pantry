defmodule OpenPantry.Web.DisplayLogic do
  @hidden_class "hidden"
  @active_class "active"
  def active(first_type, [{first_type, _, _}|_tail]), do: @active_class
  def active(_, [{_, _, _}|_tail]), do: ""

  def quantity(stock, package) do
    if sd = Enum.find(package.stock_distributions, &(&1.stock_id == stock.id)) do
      sd.quantity
    else
      0
    end
  end

  @doc """
  Removes spaces from a string, converts it to "underscore" format,
  and replaces the underscores with dashes.  Used mainly for types of
  stock or credit.  For more on the underscore format, see:
  https://hexdocs.pm/elixir/Macro.html#underscore/1

  ## Examples:

  iex> OpenPantry.Web.DisplayLogic.dasherize "American Express"
  "american-express"

  iex> OpenPantry.Web.DisplayLogic.dasherize "NASA Low Residue"
  "nasa-low-residue"
  """
  def dasherize(string) do
    string
    |> String.replace(" ", "")
    |> Macro.underscore()
    |> String.replace("_", "-")
  end

  def display_stock_type(stock_struct) do
    stock_struct
    |> to_string
    |> String.split(".")
    |> List.last
  end

  def hidden_quantity(stock, package) do
    if quantity(stock, package) == 0 do
      @hidden_class
    end
  end

  def hidden_add_to_cart(stock, package) do
    if quantity(stock, package) != 0 do
      @hidden_class
    end
  end

end
