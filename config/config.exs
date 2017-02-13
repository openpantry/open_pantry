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
config :open_pantry, OpenPantry.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EYh36bc9MEymTQNLNEVY83aY+KEngXOMsjRViOmJf33do1Lrtmwrb0x3CcIdkh1g",
  render_errors: [view: OpenPantry.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OpenPantry.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :open_pantry,
        OpenPantry.Gettext,
        locales: ~w(
                     aa
                     ab
                     af
                     ak
                     am
                     an
                     ar
                     ce
                     en
                     es
                     ht
                     fr
                     he
                     ar
                     ru
                     zh
                    )

config :ex_admin,
  repo: OpenPantry.Repo,
  module: OpenPantry,
  modules: [
    OpenPantry.ExAdmin.Dashboard,
    OpenPantry.ExAdmin.Language,
    OpenPantry.ExAdmin.Facility,
    OpenPantry.ExAdmin.User,
    OpenPantry.ExAdmin.FoodGroup,
    OpenPantry.ExAdmin.Food,
    OpenPantry.ExAdmin.Meal,
    OpenPantry.ExAdmin.Offer,
    OpenPantry.ExAdmin.Stock,
    OpenPantry.ExAdmin.UserLanguage,
    OpenPantry.ExAdmin.UserFoodPackage,
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


# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: OpenPantry.User,
  repo: OpenPantry.Repo,
  module: OpenPantry,
  logged_out_url: "/",
  email_from: {"OpenPantry", "openpantry@masbia.org"},
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :registerable]

config :coherence, OpenPantry.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: System.get_env("SENDGRID_API_KEY")
# %% End Coherence Configuration %%
