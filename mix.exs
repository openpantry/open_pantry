if !Map.has_key?(System.get_env(), "GUARDIAN_SECRET_KEY") do
  raise "GUARDIAN_SECRET_KEY environment variable not set.  It must be set for this application to work correctly"
end

defmodule OpenPantry.Mixfile do
  use Mix.Project

  def project do
    [app: :open_pantry,
     version: "0.0.1",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     dialyzer: [plt_add_deps: :transitive, plt_add_apps: [:phoenix_live_reload]],
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {OpenPantry, []},
     extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test),  do: ["lib", "test/support"]
  defp elixirc_paths(:dev),   do: ["lib", "test/support"] # for ExMachina factories for seeds
  defp elixirc_paths(_),      do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:phoenix,             "~> 1.3.0-rc", override: true},
     {:phoenix_pubsub,      "~> 1.0"},
     {:phoenix_ecto,        "~> 3.0"},
     {:postgrex,            ">= 0.0.0"},
     {:phoenix_html,        "~> 2.6"},
     {:ex_admin,            git: "https://github.com/smpallen99/ex_admin.git", branch: "phx-1.3"},
     {:gettext,             "~> 0.11"},
     {:ecto_enum,           "~> 1.0"},
     {:arc,                 "~> 0.8.0"},
     {:arc_ecto,            "~> 0.7.0"},
     {:ex_aws,              "~> 1.1" },
     {:hackney,             "~> 1.6" },
     {:poison,              "~> 3.1" },
     {:sweet_xml,           "~> 0.6" },
     {:logger_file_backend, "~> 0.0.9"},
     {:cowboy,              "~> 1.0"},
     {:guardian,            "~> 0.14"},
     {:ueberauth,           "~> 0.4"},
     {:ueberauth_identity,  "~> 0.2"},
     {:comeonin,            "~> 4.0"},
     {:bcrypt_elixir,       "~> 1.0.5"},
     {:timex,               "~> 3.0"},
     {:wallaby,             "~> 0.17",  only: :test},
     {:phoenix_live_reload, "~> 1.0",   only: :dev},
     {:credo,               "~> 0.5",   only: [:dev, :test]},
     {:dialyxir,            "~> 0.5",   only: [:dev, :test], runtime: false},
     {:ex_machina,          "~> 2.0",   only: [:dev, :test]},
     {:cortex,              "~> 0.1",   only: [:dev, :test]}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
