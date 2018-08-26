defmodule ApiWeb.Router do
  use ApiWeb, :router

  alias ApiWeb.Guardian

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

  # Use authorization via Guardian
  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  # Homepage route
  scope "/", ApiWeb do
    # Use the default browser stack
    pipe_through :browser
    get "/", PageController, :index
  end

  # API routes
  scope "/api", ApiWeb, as: :api do
    # Endpoints without authorization
    scope "/v1", Api.V1, as: :v1 do
      pipe_through :api

      post "/sign_up", UserController, :create
      post "/sign_in", UserController, :sign_in
    end

    # Endpoints with authorization
    scope "/v1", Api.V1, as: :v1 do
      pipe_through [:api, :jwt_authenticated]

      get "/current_user", UserController, :show
    end
  end
end
