defmodule OpenPantry.Plugs.Facility do
  import Ecto.Query, only: [from: 2]

  alias OpenPantry.{Repo, Facility}

  def init(_opts) do
  end

  def call(conn, _opts) do
    facility =
      case Repo.get_by(Facility, subdomain: subdomain(conn.host)) do
        nil -> Repo.one!(from Facility, limit: 1)
        facility -> facility
      end

    Plug.Conn.assign(conn, :facility, facility)
  end

  defp subdomain(host) do
    host
    |> String.split(".")
    |> hd()
  end
end
