use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :open_pantry, OpenPantry.Web.Endpoint,
  secret_key_base: "${SECRET_KEY_BASE}"

# Configure your database
config :open_pantry, OpenPantry.Repo,
  adapter: Ecto.Adapters.Postgres,
  types: OpenPantry.PostgresTypes,
  url: "${DATABASE_URL}",
  pool_size: 20,
  ssl: true

config :open_pantry, OpenPantry.Web.Endpoint,
  load_from_system_env: true,
  url: [host: "${DOMAIN}", port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json"


config :open_pantry, OpenPantry.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  ssl: true,
  pool_size: 10
