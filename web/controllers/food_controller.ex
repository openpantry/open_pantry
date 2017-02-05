defmodule OpenPantry.FoodController do
  use OpenPantry.Web, :controller

  alias OpenPantry.Food

  def index(conn, _params) do
    foods = Repo.all(Food)
    render(conn, "index.html", foods: foods)
  end

  def new(conn, _params) do
    changeset = Food.changeset(%Food{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food" => food_params}) do
    changeset = Food.changeset(%Food{}, food_params)

    case Repo.insert(changeset) do
      {:ok, _food} ->
        conn
        |> put_flash(:info, "Food created successfully.")
        |> redirect(to: food_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food = Repo.get!(Food, id)
    render(conn, "show.html", food: food)
  end

  def edit(conn, %{"id" => id}) do
    food = Repo.get!(Food, id)
    changeset = Food.changeset(food)
    render(conn, "edit.html", food: food, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food" => food_params}) do
    food = Repo.get!(Food, id)
    changeset = Food.changeset(food, food_params)

    case Repo.update(changeset) do
      {:ok, food} ->
        conn
        |> put_flash(:info, "Food updated successfully.")
        |> redirect(to: food_path(conn, :show, food))
      {:error, changeset} ->
        render(conn, "edit.html", food: food, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food = Repo.get!(Food, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(food)

    conn
    |> put_flash(:info, "Food deleted successfully.")
    |> redirect(to: food_path(conn, :index))
  end
end
