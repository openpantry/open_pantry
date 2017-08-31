defmodule OpenPantry.Web.Router do
  use OpenPantry.Web, :router
  use ExAdmin.Router

  alias OpenPantry.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plugs.Facility
  end

  pipeline :localized_browser do
    plug :browser
    plug Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_auth do
    plug Plugs.Authentication, use_config: {:open_pantry, :admin_auth}
  end

  pipeline :user_required do
    plug Plugs.SetupUser, redirect_url: "/user_selections"
  end

  scope "/admin", ExAdmin do
    pipe_through [:browser, :admin_auth]
    admin_routes()
  end

  scope "/manage", OpenPantry.Web do
    pipe_through [:browser, :admin_auth]
    resources "/stocks", StockController
    resources "/orders", UserOrderController, only: [:index, :show]
    resources "/facilities", FacilityController
  end

  scope "/", OpenPantry.Web do
    pipe_through [:browser, :admin_auth]
    resources "/user_selections", UserSelectionController
  end



  scope "/", OpenPantry.Web do
    pipe_through [:browser]
    resources "/languages", LanguageController
    resources "/sessions", SessionController
  end

  scope "/", OpenPantry.Web do
    pipe_through [:localized_browser] # Use the default browser stack

    get "/", PageController, :unused
  end


  scope "/:locale", OpenPantry.Web do
    pipe_through [:localized_browser, :user_required]

    get "/", PageController, :index
    get "/styleguide", StyleController, :index
    resources "/registrations", RegistrationController
    resources "/food_selections", FoodSelectionController
    resources "/upc_products", UpcProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", OpenPantry do
  #   pipe_through :api
  # end
end
