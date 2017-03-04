defmodule OpenPantry.Web.Router do
  use OpenPantry.Web, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug FakeUser
    plug :put_user_token_and_facility
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

  scope "/", OpenPantry.Web do
    pipe_through :browser

    resources "/languages", LanguageController
    resources "/facilities", FacilityController
  end

  scope "/", OpenPantry.Web do
    pipe_through :localized_browser # Use the default browser stack

    get "/", PageController, :unused
  end


  scope "/:locale", OpenPantry.Web do
    pipe_through [:localized_browser]

    get "/", PageController, :index
    resources "/registrations", RegistrationController
    resources "/food_selections", FoodSelectionController
    resources "/upc_products", UpcProductController
  end

  defp put_user_token_and_facility(conn, _) do
    if current_user = conn.assigns[:user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      conn
      |> assign(:user_token, token)
      |> assign(:facility_id, current_user.facility_id)
    else
      conn
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", OpenPantry do
  #   pipe_through :api
  # end
end
