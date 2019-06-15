# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  ecto_repos: [Api.Repo]

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "giSKRtc/lpc8nhWE3HQjJisu4gq6oRc3PX9a1aszU5sia/NFCjL8vO2sCtHN6noR",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Api.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Guardian config
config :api, ApiWeb.Guardian,
  issuer: "myApi",
  secret_key: "s6O36Q2DtK/sODiSaOtrHROakNiEHxqUkjnVGw6cvTk33wR0wo1e4s7et9X5NRn3"

# Configure bcrypt for passwords
config :comeonin, :bcrypt_log_rounds, 4

# Swagger
config :api, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: ApiWeb.Router,
      # (optional) endpoint config used to set host, port and https schemes.
      endpoint: ApiWeb.Endpoint
    ]
  }

# Git hooks
config :git_hooks,
  verbose: true,
  hooks: [
    pre_commit: [
      tasks: [
        "mix format"
      ]
    ],
    pre_push: [
      verbose: false,
      tasks: [
        "echo 'success!'"
      ]
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
