defmodule OpenPantry.Router do
  use OpenPantry.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OpenPantry do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/languages", LanguageController
    resources "/facilities", FacilityController
    resources "/food_groups", FoodGroupController
    resources "/food", FoodController
    resources "/food_group_memberships", FoodGroupMembershipController
    resources "/stocks", StockController
  end

  # Other scopes may use custom stacks.
  # scope "/api", OpenPantry do
  #   pipe_through :api
  # end
end
