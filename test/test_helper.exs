ExUnit.configure(exclude: [pending: true])
ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(OpenPantry.Repo, :manual)
Application.put_env(:wallaby, :base_url, OpenPantry.Web.Endpoint.url)
Application.put_env(:wallaby, :screenshot_on_failure, true)
if System.get_env("CIRCLE_ARTIFACTS") do
  Application.put_env(:wallaby, :screenshot_dir, System.get_env("CIRCLE_ARTIFACTS"))
end
{:ok, _} = Application.ensure_all_started(:wallaby)
{:ok, _} = Application.ensure_all_started(:ex_machina)
