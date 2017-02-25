ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(OpenPantry.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:wallaby)
{:ok, _} = Application.ensure_all_started(:ex_machina)
Application.put_env(:wallaby, :base_url, OpenPantry.Endpoint.url)
Application.put_env(:wallaby, :screenshot_on_failure, true)