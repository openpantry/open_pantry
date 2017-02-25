use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :open_pantry, OpenPantry.Endpoint,
  http: [port: 4001],
  server: true

config :open_pantry, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :open_pantry, OpenPantry.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "open_pantry_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
