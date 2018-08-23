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

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  # Homepage route
  scope "/", ApiWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
  end

  # API routes
  scope "/api", ApiWeb, as: :api do
    pipe_through :api

    scope "/v1", Api.V1, as: :v1 do
      post "/sign_up", UserController, :create
      post "/sign_in", UserController, :sign_in
    end
  end

  scope "/api", ApiWeb, as: :api do
    pipe_through [:api, :jwt_authenticated]

    scope "/v1", Api.V1, as: :v1 do
      get "/current_user", UserController, :show
    end
  end
end
