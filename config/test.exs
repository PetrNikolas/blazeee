use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api, ApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :api, Api.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "blazeee_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Bcrypt for hash user's password
config :bcrypt_elixir, :log_rounds, 4