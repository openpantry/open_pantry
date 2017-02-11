defmodule OpenPantry.MealController do
  use OpenPantry.Web, :controller

  alias OpenPantry.Meal

  def index(conn, _params) do
    meals = Repo.all(Meal)
    render(conn, "index.html", meals: meals)
  end

  def new(conn, _params) do
    changeset = Meal.changeset(%Meal{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"meal" => meal_params}) do
    changeset = Meal.changeset(%Meal{}, meal_params)

    case Repo.insert(changeset) do
      {:ok, _meal} ->
        conn
        |> put_flash(:info, "Meal created successfully.")
        |> redirect(to: meal_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meal = Repo.get!(Meal, id)
    render(conn, "show.html", meal: meal)
  end

  def edit(conn, %{"id" => id}) do
    meal = Repo.get!(Meal, id)
    changeset = Meal.changeset(meal)
    render(conn, "edit.html", meal: meal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "meal" => meal_params}) do
    meal = Repo.get!(Meal, id)
    changeset = Meal.changeset(meal, meal_params)

    case Repo.update(changeset) do
      {:ok, meal} ->
        conn
        |> put_flash(:info, "Meal updated successfully.")
        |> redirect(to: meal_path(conn, :show, meal))
      {:error, changeset} ->
        render(conn, "edit.html", meal: meal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meal = Repo.get!(Meal, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(meal)

    conn
    |> put_flash(:info, "Meal deleted successfully.")
    |> redirect(to: meal_path(conn, :index))
  end
end
