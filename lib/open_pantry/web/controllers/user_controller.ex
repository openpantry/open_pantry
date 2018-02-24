defmodule OpenPantry.Web.UserController do
  use OpenPantry.Web, :controller

  alias Ecto.Query
  alias OpenPantry.Repo
  alias OpenPantry.User
  alias OpenPantry.Facility

  def index(conn, _params) do
    users = User |> Repo.filter_facility(conn) |> Repo.all
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%OpenPantry.User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = get_user(id, conn)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = get_user(id, conn)
    changeset = User.changeset(user, %{})
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = get_user(id, conn)

    case update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = get_user(id, conn)
    {:ok, _user} = Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  defp get_user(id, conn) do
    User |> Repo.filter_facility(conn) |> Query.preload(:managed_facilities) |> Repo.get!(id)
  end

  defp create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  defp update_user(%User{} = user, attrs) do
    managed_facilities = Facility |> Query.where([f], f.id in ^attrs["managed_facilities"]) |> Repo.all
    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:managed_facilities, managed_facilities)
    |> Repo.update()
  end
end
