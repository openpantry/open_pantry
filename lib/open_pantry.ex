defmodule OpenPantry do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    if !Application.get_env(:guardian, Guardian)[:secret_key] do
      raise "GUARDIAN_SECRET_KEY environment variable not set.  It must be set for this application to work correctly"
    end

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(OpenPantry.Repo, []),
      # Start the endpoint when the application starts
      supervisor(OpenPantry.Web.Endpoint, []),
      # Start your own worker by calling: OpenPantry.Worker.start_link(arg1, arg2, arg3)
      # worker(OpenPantry.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OpenPantry.Web.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
