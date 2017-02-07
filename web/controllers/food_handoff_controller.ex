defmodule OpenPantry.FoodHandoffController do
  use OpenPantry.Web, :controller

  alias OpenPantry.FoodHandoff

  def index(conn, _params) do
    food_handoffs = Repo.all(FoodHandoff)
    render(conn, "index.html", food_handoffs: food_handoffs)
  end

  def new(conn, _params) do
    changeset = FoodHandoff.changeset(%FoodHandoff{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_handoff" => food_handoff_params}) do
    changeset = FoodHandoff.changeset(%FoodHandoff{}, food_handoff_params)

    case Repo.insert(changeset) do
      {:ok, _food_handoff} ->
        conn
        |> put_flash(:info, "Food handoff created successfully.")
        |> redirect(to: food_handoff_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_handoff = Repo.get!(FoodHandoff, id)
    render(conn, "show.html", food_handoff: food_handoff)
  end

  def edit(conn, %{"id" => id}) do
    food_handoff = Repo.get!(FoodHandoff, id)
    changeset = FoodHandoff.changeset(food_handoff)
    render(conn, "edit.html", food_handoff: food_handoff, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_handoff" => food_handoff_params}) do
    food_handoff = Repo.get!(FoodHandoff, id)
    changeset = FoodHandoff.changeset(food_handoff, food_handoff_params)

    case Repo.update(changeset) do
      {:ok, food_handoff} ->
        conn
        |> put_flash(:info, "Food handoff updated successfully.")
        |> redirect(to: food_handoff_path(conn, :show, food_handoff))
      {:error, changeset} ->
        render(conn, "edit.html", food_handoff: food_handoff, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_handoff = Repo.get!(FoodHandoff, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(food_handoff)

    conn
    |> put_flash(:info, "Food handoff deleted successfully.")
    |> redirect(to: food_handoff_path(conn, :index))
  end
end
