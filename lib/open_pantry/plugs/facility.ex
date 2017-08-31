defmodule OpenPantry.Plugs.Facility do
  alias OpenPantry.{Repo, Facility}

  def init(_opts) do
    Application.get_env(:open_pantry, OpenPantry.Web.Endpoint)[:url][:host]
    |> String.length()
  end

  def call(conn, domain_length) do
    subdomain = subdomain(conn.host, domain_length)
    facility = Repo.get_by!(Facility, subdomain: subdomain)

    Plug.Conn.assign(conn, :facility, facility)
  end

  defp subdomain(host, domain_length) do
    to = -domain_length - 2
    String.slice(host, 0..to)
  end
end
