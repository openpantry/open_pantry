defmodule OpenPantry.UserFoodPackageController do
  use OpenPantry.Web, :controller

  alias OpenPantry.UserFoodPackage

  def index(conn, _params) do
    user_food_packages = Repo.all(UserFoodPackage)
    render(conn, "index.html", user_food_packages: user_food_packages)
  end

  def new(conn, _params) do
    changeset = UserFoodPackage.changeset(%UserFoodPackage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_food_package" => user_food_package_params}) do
    changeset = UserFoodPackage.changeset(%UserFoodPackage{}, user_food_package_params)

    case Repo.insert(changeset) do
      {:ok, _user_food_package} ->
        conn
        |> put_flash(:info, "User food package created successfully.")
        |> redirect(to: user_food_package_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_food_package = Repo.get!(UserFoodPackage, id)
    render(conn, "show.html", user_food_package: user_food_package)
  end

  def edit(conn, %{"id" => id}) do
    user_food_package = Repo.get!(UserFoodPackage, id)
    changeset = UserFoodPackage.changeset(user_food_package)
    render(conn, "edit.html", user_food_package: user_food_package, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_food_package" => user_food_package_params}) do
    user_food_package = Repo.get!(UserFoodPackage, id)
    changeset = UserFoodPackage.changeset(user_food_package, user_food_package_params)

    case Repo.update(changeset) do
      {:ok, user_food_package} ->
        conn
        |> put_flash(:info, "User food package updated successfully.")
        |> redirect(to: user_food_package_path(conn, :show, user_food_package))
      {:error, changeset} ->
        render(conn, "edit.html", user_food_package: user_food_package, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_food_package = Repo.get!(UserFoodPackage, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_food_package)

    conn
    |> put_flash(:info, "User food package deleted successfully.")
    |> redirect(to: user_food_package_path(conn, :index))
  end
end
