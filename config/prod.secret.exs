use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :open_pantry, OpenPantry.Endpoint,
  secret_key_base: "E6YxIoGUi8FVAsVARMFHtdQ0TCU2XxMnhgNLTkoRnnd9iXH7T8R4xCzMcJZoOu8g"

# Configure your database
config :open_pantry, OpenPantry.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "open_pantry_prod",
  pool_size: 20
