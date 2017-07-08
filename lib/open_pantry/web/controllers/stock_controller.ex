defmodule OpenPantry.Web.StockController do
  use OpenPantry.Web, :controller

  alias OpenPantry.Stock

  def index(conn, _params) do
    stocks = Repo.all(Stock)
    render(conn, "index.html", stocks: stocks)
  end

  def new(conn, _params) do
    changeset = Stock.changeset(%Stock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock" => stock_params}) do
    changeset = Stock.changeset(%Stock{}, stock_params)
    case Repo.insert(changeset) do
      {:ok, _stock} ->
        conn
        |> put_flash(:info, "Stock created successfully.")
        |> redirect(to: stock_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stock = Repo.get!(Stock, id)
    render(conn, "show.html", stock: stock)
  end

  def edit(conn, %{"id" => id}) do
    stock = Repo.get!(Stock, id)
    changeset = Stock.changeset(stock)
    render(conn, "edit.html", stock: stock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock" => stock_params}) do
    stock = Repo.get!(Stock, id)
    changeset = Stock.changeset(stock, stock_params)

    case Repo.update(changeset) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Stock updated successfully.")
        |> redirect(to: stock_path(conn, :show, stock))
      {:error, changeset} ->
        render(conn, "edit.html", stock: stock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock = Repo.get!(Stock, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stock)

    conn
    |> put_flash(:info, "Stock deleted successfully.")
    |> redirect(to: stock_path(conn, :index))
  end
end
