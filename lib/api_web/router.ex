defmodule ApiWeb.Router do
  use ApiWeb, :router

  alias ApiWeb.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Use authorization via Guardian
  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  # Homepage route
  scope "/", ApiWeb do
    pipe_through :api
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

      get "/users", UserController, :index
      get "/user", UserController, :get_current_user
      get "/user/:id", UserController, :show
      put "/user/:id", UserController, :update
      delete "/user/:id", UserController, :delete
    end
  end

  # Endpoint for GraphQL
  scope "/api" do 
    pipe_through [:api, :jwt_authenticated]
    
    forward "/graphql", Absinthe.Plug,
      schema: ApiWeb.Schema
  end
  # For the GraphiQL interactive interface, a must-have for happy frontend devs.
  forward "/api/graphiql", Absinthe.Plug.GraphiQL,
    schema: ApiWeb.Schema,
    interface: :simple
end
