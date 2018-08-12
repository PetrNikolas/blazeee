defmodule ApiWeb.Router do
  use ApiWeb, :router

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

  # Homepage route
  scope "/", ApiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:show]
  end

  # API routes
  scope "/api", ApiWeb, as: :api do
    pipe_through :api
    scope "/v1", Api.V1, as: :v1 do
      resources "/users", UserController
    end
  end
end
