defmodule OpenPantry.Web.UserSelectionController do
  use OpenPantry.Web, :controller
  alias OpenPantry.User
  alias OpenPantry.CreditType
  alias OpenPantry.UserCredit
  alias OpenPantry.Facility
  @hardcoded_facility_id 1
  @unknown_language_id 184
  @start_credit_balance 18

  def index(conn, _params) do
    facility = Facility.find(@hardcoded_facility_id, :users)
    render conn, "index.html",  users: facility.users, conn: conn, changeset: User.changeset(%User{})
  end

  def show(conn, params) do
    user = User.find(params["id"] |> String.to_integer) # make sure user exists
    redirect_and_notify(conn, user)
  end

  def create(conn, params) do
    user =  User.changeset(%User{}, %{name: name_from_params(params),
                                      family_members: 1,
                                      primary_language_id: @unknown_language_id,
                                      facility_id: @hardcoded_facility_id,
                                     })
            |> Repo.insert!()

    for credit_type <- CreditType |> Repo.all do
      UserCredit.changeset(%UserCredit{},
        %{credit_type_id: credit_type.id, user_id: user.id, balance: @start_credit_balance })
      |> Repo.insert!()
    end
    redirect_and_notify(conn, user)
  end

  def delete(conn, _params) do
    conn
    |> clear_session
    |> delete_resp_header("authorization")
    |> Plug.Conn.delete_resp_cookie("user_id")
    |> redirect(to: "/")
  end

  defp name_from_params(params) do
    if Blank.blank?(params["user"]["name"]) do
      "Anonymous"
    else
      params["user"]["name"]
    end
  end


  defp redirect_and_notify(conn, user) do
    conn
    |> Plug.Conn.put_resp_cookie("user_id", Integer.to_string(user.id))
    |> redirect(to: "/en/")
    |> put_flash(:info, "You are now logged in as #{user.name}, user id ##{user.id}")
    |> halt
  end

end
