defmodule OpenPantry.Plugs.SetupUser do
  alias OpenPantry.User
  alias OpenPantry.Repo
  alias OpenPantry.Web.UserSelectionView
  def init(opts), do: opts
  import Plug.Conn
  require IEx

  def call(conn, opts) do
    conn
    |> assign_user_from_cookie_or_token(opts)
    |> put_user_token_and_facility
    |> redirect_unless_user_present(Map.new(opts))
  end

  defp assign_user_from_cookie_or_token(conn, _opts) do
    cond do
      conn.query_params["login"] -> {:ok, conn.query_params["login"] }
      conn.cookies["user_token"] -> {:ok, conn.cookies["user_token"] }
      true                       -> {:error, :no_token }
    end
    |> user_from_token(conn)
    |> put_cookie_if_logging_in()
    |> assign_user_to_conn()
  end

  defp put_user_token_and_facility(conn) do
    if current_user = conn.assigns[:user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      conn
      |> assign(:user_token, token)
      |> assign(:facility_id, current_user.facility_id)
    else
      conn
    end
  end

  defp redirect_unless_user_present(conn, opts) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: opts.redirect_url)
      |> halt
    end
  end

  defp user_from_token({:ok, token}, conn) do
    %{"aud" => <<"User:",  id :: binary >>} = Guardian.decode_and_verify!(token)
    user = String.to_integer(id)
          |> User.query
          |> Repo.one
    {conn, user}
  end

  defp user_from_token({:error, :no_token}, conn) do
    {conn, User.guest() }
  end

  defp assign_user_to_conn({conn, user}) do
    conn
    |> assign(:user, user)
    |> assign(:user_name, user.name)
  end

  defp put_cookie_if_logging_in({conn, user}) do
    if conn.query_params["login"] do
      {Plug.Conn.put_resp_cookie(conn, "user_token", UserSelectionView.login_token(user)), user}
    else
      {conn, user}
    end
  end
end
