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
  end

  pipeline :facility_specified do
    plug Plugs.Facility
  end

  pipeline :localized_browser do
    plug :browser
    plug Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :admin_auth do
    plug Guardian.Plug.EnsureAuthenticated, handler: OpenPantry.Web.AuthController
    plug Guardian.Plug.EnsurePermissions, handler: OpenPantry.Web.AuthController,
      one_of: [%{role: [:admin]}, %{role: [:superadmin]}]
  end

  pipeline :user_required do
    plug Plugs.SetupUser, redirect_url: "/user_selections"
  end

  scope "/auth", OpenPantry.Web do
    pipe_through [:browser, :browser_auth]

    get "/logout", AuthController, :delete
    delete "/logout", AuthController, :delete
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/identity/callback", AuthController, :callback
  end

  scope "/admin", ExAdmin do
    pipe_through [:browser, :browser_auth, :admin_auth]
    admin_routes()
  end

  scope "/manage", OpenPantry.Web do
    pipe_through [:browser, :browser_auth, :admin_auth]
    resources "/stocks", StockController
    resources "/orders", UserOrderController, only: [:index, :show]
    resources "/facilities", FacilityController
    resources "/users", UserController
  end

  scope "/", OpenPantry.Web do
    pipe_through [:browser, :browser_auth, :facility_specified, :admin_auth]
    resources "/user_selections", UserSelectionController
  end

  scope "/", OpenPantry.Web do
    pipe_through [:browser, :browser_auth]
    resources "/languages", LanguageController
    resources "/sessions", SessionController
  end

  scope "/", OpenPantry.Web do
    pipe_through [:localized_browser, :browser_auth, :facility_specified] # Use the default browser stack

    get "/", PageController, :unused
  end


  scope "/:locale", OpenPantry.Web do
    pipe_through [:localized_browser, :browser_auth, :facility_specified, :user_required]

    get "/", PageController, :index
  end

  scope "/:locale", OpenPantry.Web do
    pipe_through [:localized_browser, :facility_specified, :user_required]
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
