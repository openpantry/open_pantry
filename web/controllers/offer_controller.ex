defmodule OpenPantry.OfferController do
  use OpenPantry.Web, :controller

  alias OpenPantry.Offer

  def index(conn, _params) do
    offers = Repo.all(Offer)
    render(conn, "index.html", offers: offers)
  end

  def new(conn, _params) do
    changeset = Offer.changeset(%Offer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"offer" => offer_params}) do
    changeset = Offer.changeset(%Offer{}, offer_params)

    case Repo.insert(changeset) do
      {:ok, _offer} ->
        conn
        |> put_flash(:info, "Offer created successfully.")
        |> redirect(to: offer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    offer = Repo.get!(Offer, id)
    render(conn, "show.html", offer: offer)
  end

  def edit(conn, %{"id" => id}) do
    offer = Repo.get!(Offer, id)
    changeset = Offer.changeset(offer)
    render(conn, "edit.html", offer: offer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "offer" => offer_params}) do
    offer = Repo.get!(Offer, id)
    changeset = Offer.changeset(offer, offer_params)

    case Repo.update(changeset) do
      {:ok, offer} ->
        conn
        |> put_flash(:info, "Offer updated successfully.")
        |> redirect(to: offer_path(conn, :show, offer))
      {:error, changeset} ->
        render(conn, "edit.html", offer: offer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    offer = Repo.get!(Offer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(offer)

    conn
    |> put_flash(:info, "Offer deleted successfully.")
    |> redirect(to: offer_path(conn, :index))
  end
end
