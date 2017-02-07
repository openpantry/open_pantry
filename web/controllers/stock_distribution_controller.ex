defmodule OpenPantry.StockDistributionController do
  use OpenPantry.Web, :controller

  alias OpenPantry.StockDistribution

  def index(conn, _params) do
    stock_distributions = Repo.all(StockDistribution)
    render(conn, "index.html", stock_distributions: stock_distributions)
  end

  def new(conn, _params) do
    changeset = StockDistribution.changeset(%StockDistribution{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stock_distribution" => stock_distribution_params}) do
    changeset = StockDistribution.changeset(%StockDistribution{}, stock_distribution_params)

    case Repo.insert(changeset) do
      {:ok, _stock_distribution} ->
        conn
        |> put_flash(:info, "Stock distribution created successfully.")
        |> redirect(to: stock_distribution_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stock_distribution = Repo.get!(StockDistribution, id)
    render(conn, "show.html", stock_distribution: stock_distribution)
  end

  def edit(conn, %{"id" => id}) do
    stock_distribution = Repo.get!(StockDistribution, id)
    changeset = StockDistribution.changeset(stock_distribution)
    render(conn, "edit.html", stock_distribution: stock_distribution, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock_distribution" => stock_distribution_params}) do
    stock_distribution = Repo.get!(StockDistribution, id)
    changeset = StockDistribution.changeset(stock_distribution, stock_distribution_params)

    case Repo.update(changeset) do
      {:ok, stock_distribution} ->
        conn
        |> put_flash(:info, "Stock distribution updated successfully.")
        |> redirect(to: stock_distribution_path(conn, :show, stock_distribution))
      {:error, changeset} ->
        render(conn, "edit.html", stock_distribution: stock_distribution, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_distribution = Repo.get!(StockDistribution, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stock_distribution)

    conn
    |> put_flash(:info, "Stock distribution deleted successfully.")
    |> redirect(to: stock_distribution_path(conn, :index))
  end
end
