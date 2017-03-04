defmodule OpenPantry.Web.AcceptanceCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias OpenPantry.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import OpenPantry.Web.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(OpenPantry.Repo)

    Ecto.Adapters.SQL.Sandbox.mode(OpenPantry.Repo, {:shared, self()})

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(OpenPantry.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end