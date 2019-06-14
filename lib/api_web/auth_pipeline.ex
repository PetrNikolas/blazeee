defmodule ApiWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :MyApi,
    module: ApiWeb.Guardian,
    error_handler: ApiWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
