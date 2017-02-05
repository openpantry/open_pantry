defmodule OpenPantry.FoodGroupController do
  use OpenPantry.Web, :controller

  alias OpenPantry.FoodGroup

  def index(conn, _params) do
    food_groups = Repo.all(FoodGroup)
    render(conn, "index.html", food_groups: food_groups)
  end

  def new(conn, _params) do
    changeset = FoodGroup.changeset(%FoodGroup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_group" => food_group_params}) do
    changeset = FoodGroup.changeset(%FoodGroup{}, food_group_params)

    case Repo.insert(changeset) do
      {:ok, _food_group} ->
        conn
        |> put_flash(:info, "Food group created successfully.")
        |> redirect(to: food_group_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_group = Repo.get!(FoodGroup, id)
    render(conn, "show.html", food_group: food_group)
  end

  def edit(conn, %{"id" => id}) do
    food_group = Repo.get!(FoodGroup, id)
    changeset = FoodGroup.changeset(food_group)
    render(conn, "edit.html", food_group: food_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_group" => food_group_params}) do
    food_group = Repo.get!(FoodGroup, id)
    changeset = FoodGroup.changeset(food_group, food_group_params)

    case Repo.update(changeset) do
      {:ok, food_group} ->
        conn
        |> put_flash(:info, "Food group updated successfully.")
        |> redirect(to: food_group_path(conn, :show, food_group))
      {:error, changeset} ->
        render(conn, "edit.html", food_group: food_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_group = Repo.get!(FoodGroup, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(food_group)

    conn
    |> put_flash(:info, "Food group deleted successfully.")
    |> redirect(to: food_group_path(conn, :index))
  end
end
