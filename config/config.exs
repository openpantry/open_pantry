# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :open_pantry,
  ecto_repos: [OpenPantry.Repo]

# Configures the endpoint
config :open_pantry, OpenPantry.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EYh36bc9MEymTQNLNEVY83aY+KEngXOMsjRViOmJf33do1Lrtmwrb0x3CcIdkh1g",
  render_errors: [view: OpenPantry.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OpenPantry.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :open_pantry,
        OpenPantry.Web.Gettext,
        locales: ~w(
                     ar
                     en
                     es
                     ht
                     fr
                     he
                     ar
                     ru
                     zh
                    )

config :open_pantry, admin_auth: [
  username: "admin",
  password: {:system, "ADMIN_PASSWORD"},
  realm: "Admin Area"
]

config :open_pantry, user_auth: [
  username: "admin",
  password: {:system, "USER_PASSWORD"},
  realm: "Food Selection"
]

config :open_pantry, :authentication, BasicAuth
config :ex_admin,
  repo: OpenPantry.Repo,
  module: OpenPantry.Web,
  modules: [
    OpenPantry.ExAdmin.Dashboard,
    OpenPantry.ExAdmin.Language,
    OpenPantry.ExAdmin.Facility,
    OpenPantry.ExAdmin.CreditType,
    OpenPantry.ExAdmin.CreditTypeMembership,
    OpenPantry.ExAdmin.User,
    OpenPantry.ExAdmin.FoodGroup,
    OpenPantry.ExAdmin.Food,
    OpenPantry.ExAdmin.Meal,
    OpenPantry.ExAdmin.Offer,
    OpenPantry.ExAdmin.Stock,
    OpenPantry.ExAdmin.UserLanguage,
    OpenPantry.ExAdmin.UserOrder,
    OpenPantry.ExAdmin.UserCredit,
    OpenPantry.ExAdmin.StockDistribution,
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}
config :arc,
  storage: Arc.Storage.S3,
  bucket: "open-pantry-stock-images" # hardcoding for now, should probably be env var long term
