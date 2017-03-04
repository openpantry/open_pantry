defmodule OpenPantry.FoodSelectionTest do
  use OpenPantry.Web.AcceptanceCase, async: true
  import OpenPantry.CompleteFacility
  test "selection table has tab per credit type, plus meals and cart", %{session: session} do
    %{credit_types: [credit_type|_]} = two_credit_facility()

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    assert first_credit =~ ~r/#{credit_type.name}/
  end

  test "selection table shows first foods in stock on load", %{session: session} do
    %{credit_types: [credit_type|_], foods: [food|_]} = two_credit_facility()

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    assert first_credit =~ ~r/#{food.longdesc}/
  end

  test "selection table does not show second food in stock on load", %{session: session} do
    %{credit_types: [credit_type|_], foods: [_|[food2]]} = two_credit_facility()

    first_credit = session
    |> visit("/en/food_selections")
    |> find("##{credit_type.name}")
    |> text

    refute first_credit =~ ~r/#{food2.longdesc}/
  end

  test "selection table allows selecting second tab", %{session: session} do
    %{credit_types: [_|[credit_type2]], foods: [_|[food2]]} = two_credit_facility()

    second_credit = session
    |> visit("/en/food_selections")
    |> click_link(credit_type2.name)
    |> find("##{credit_type2.name}")
    |> text

    assert second_credit =~ ~r/#{food2.longdesc}/
  end

  test "clicking + adds to cart, decrements stock quantity", %{session: session} do
    one_credit_facility()
    session = visit(session, "/en/food_selections")

    {before_stock, before_requested} = {stock_available(session), stock_requested(session)}
    take_screenshot session
    session = click_button(session, "+")
    Process.sleep(500)
    take_screenshot session
    {after_stock, after_requested} = {stock_available(session), stock_requested(session)}

    assert (before_stock - after_stock) == 1
    assert (after_requested - before_requested) == 1
  end

  def stock_available(session), do: quantity(".js-available-quantity", session)
  def stock_requested(session), do: quantity(".js-current-quantity", session)

  def quantity(selector, session) do
    session
    |> find(selector)
    |> text
    |> String.to_integer
  end

end