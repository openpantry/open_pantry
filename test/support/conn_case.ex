defmodule OpenPantry.Web.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  @default_opts [
    store: :cookie,
    key: "secretkey",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt"
  ]
  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias OpenPantry.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import OpenPantry.Web.Router.Helpers

      # The default endpoint for testing
      @endpoint OpenPantry.Web.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(OpenPantry.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(OpenPantry.Repo, {:shared, self()})
    end

    {conn, user} =
      if tags[:authenticated] do
        user = %OpenPantry.User{
          name: "test",
          role: :superadmin
        }
        conn =
          Phoenix.ConnTest.build_conn()
          |> Plug.Session.call(@signing_opts)
          |> Plug.Conn.fetch_session
          |> Guardian.Plug.sign_in(user, :admin, perms: %{role: [user.role]})
          |> Guardian.Plug.VerifySession.call(%{})
        {conn, user}
      else
        {Phoenix.ConnTest.build_conn(), nil}
      end

    {:ok, conn: conn, user: user}
  end
end
