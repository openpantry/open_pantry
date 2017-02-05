defmodule OpenPantry.UserLanguageController do
  use OpenPantry.Web, :controller

  alias OpenPantry.UserLanguage

  def index(conn, _params) do
    user_languages = Repo.all(UserLanguage)
    render(conn, "index.html", user_languages: user_languages)
  end

  def new(conn, _params) do
    changeset = UserLanguage.changeset(%UserLanguage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_language" => user_language_params}) do
    changeset = UserLanguage.changeset(%UserLanguage{}, user_language_params)

    case Repo.insert(changeset) do
      {:ok, _user_language} ->
        conn
        |> put_flash(:info, "User language created successfully.")
        |> redirect(to: user_language_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_language = Repo.get!(UserLanguage, id)
    render(conn, "show.html", user_language: user_language)
  end

  def edit(conn, %{"id" => id}) do
    user_language = Repo.get!(UserLanguage, id)
    changeset = UserLanguage.changeset(user_language)
    render(conn, "edit.html", user_language: user_language, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_language" => user_language_params}) do
    user_language = Repo.get!(UserLanguage, id)
    changeset = UserLanguage.changeset(user_language, user_language_params)

    case Repo.update(changeset) do
      {:ok, user_language} ->
        conn
        |> put_flash(:info, "User language updated successfully.")
        |> redirect(to: user_language_path(conn, :show, user_language))
      {:error, changeset} ->
        render(conn, "edit.html", user_language: user_language, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_language = Repo.get!(UserLanguage, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_language)

    conn
    |> put_flash(:info, "User language deleted successfully.")
    |> redirect(to: user_language_path(conn, :index))
  end
end
