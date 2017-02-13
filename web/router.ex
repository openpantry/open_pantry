defmodule OpenPantry.Router do
  use OpenPantry.Web, :router
  use ExAdmin.Router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  pipeline :localized_browser do
    plug :browser
    plug OpenPantry.Plug.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes()
  end

  scope "/", OpenPantry do
    pipe_through :browser

    resources "/languages", LanguageController
    resources "/facilities", FacilityController
  end

  scope "/", OpenPantry do
    pipe_through :localized_browser # Use the default browser stack

    get "/", PageController, :unused
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/:locale", OpenPantry do
    pipe_through [:localized_browser]

    get "/", PageController, :index
    resources "/registrations", RegistrationController

  end

  # Other scopes may use custom stacks.
  # scope "/api", OpenPantry do
  #   pipe_through :api
  # end
end
