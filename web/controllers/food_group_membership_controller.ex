defmodule OpenPantry.FoodGroupMembershipController do
  use OpenPantry.Web, :controller

  alias OpenPantry.FoodGroupMembership

  def index(conn, _params) do
    food_group_memberships = Repo.all(FoodGroupMembership)
    render(conn, "index.html", food_group_memberships: food_group_memberships)
  end

  def new(conn, _params) do
    changeset = FoodGroupMembership.changeset(%FoodGroupMembership{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_group_membership" => food_group_membership_params}) do
    changeset = FoodGroupMembership.changeset(%FoodGroupMembership{}, food_group_membership_params)

    case Repo.insert(changeset) do
      {:ok, _food_group_membership} ->
        conn
        |> put_flash(:info, "Food group membership created successfully.")
        |> redirect(to: food_group_membership_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_group_membership = Repo.get!(FoodGroupMembership, id)
    render(conn, "show.html", food_group_membership: food_group_membership)
  end

  def edit(conn, %{"id" => id}) do
    food_group_membership = Repo.get!(FoodGroupMembership, id)
    changeset = FoodGroupMembership.changeset(food_group_membership)
    render(conn, "edit.html", food_group_membership: food_group_membership, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_group_membership" => food_group_membership_params}) do
    food_group_membership = Repo.get!(FoodGroupMembership, id)
    changeset = FoodGroupMembership.changeset(food_group_membership, food_group_membership_params)

    case Repo.update(changeset) do
      {:ok, food_group_membership} ->
        conn
        |> put_flash(:info, "Food group membership updated successfully.")
        |> redirect(to: food_group_membership_path(conn, :show, food_group_membership))
      {:error, changeset} ->
        render(conn, "edit.html", food_group_membership: food_group_membership, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_group_membership = Repo.get!(FoodGroupMembership, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(food_group_membership)

    conn
    |> put_flash(:info, "Food group membership deleted successfully.")
    |> redirect(to: food_group_membership_path(conn, :index))
  end
end
