defmodule OpenPantry.Web.FacilityController do
  use OpenPantry.Web, :controller

  alias OpenPantry.Facility

  def index(conn, _params) do
    facilities = Repo.all(Facility)
    render(conn, "index.html", facilities: facilities)
  end

  def new(conn, _params) do
    changeset = Facility.changeset(%Facility{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"facility" => facility_params}) do
    changeset = Facility.changeset(%Facility{}, facility_params)

    case Repo.insert(changeset) do
      {:ok, _facility} ->
        conn
        |> put_flash(:info, "Facility created successfully.")
        |> redirect(to: facility_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    facility = Repo.get!(Facility, id)
    render(conn, "show.html", facility: facility)
  end

  def edit(conn, %{"id" => id}) do
    facility = Repo.get!(Facility, id)
    changeset = Facility.changeset(facility)
    render(conn, "edit.html", facility: facility, changeset: changeset)
  end

  def update(conn, %{"id" => id, "facility" => facility_params}) do
    facility = Repo.get!(Facility, id)
    changeset = Facility.changeset(facility, facility_params)

    case Repo.update(changeset) do
      {:ok, facility} ->
        conn
        |> put_flash(:info, "Facility updated successfully.")
        |> redirect(to: facility_path(conn, :show, facility))
      {:error, changeset} ->
        render(conn, "edit.html", facility: facility, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    facility = Repo.get!(Facility, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(facility)

    conn
    |> put_flash(:info, "Facility deleted successfully.")
    |> redirect(to: facility_path(conn, :index))
  end
end
