# Blazeee
Blazeee: Full-Stack solution for rapid development.

Version: "0.0.4"

## Prerequisites
  * [Elixir 1.4 or later](https://elixir-lang.org/)
  * [Erlang 18 or later](https://www.erlang.org/)
  * [Phoenix framework](https://phoenixframework.org/)
  * [Node.js (>= 5.0.0)](https://nodejs.org/en/)
  * [PostgreSQL](https://www.postgresql.org/)

## Libs
  * [Bcrypt](https://github.com/riverrun/bcrypt_elixir)
  * [Corsica](https://github.com/whatyouhide/corsica)
  * [Comeonin](https://github.com/riverrun/comeonin)
  * [Guardian](https://github.com/ueberauth/guardian)

## Setup project
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

NOTE: These types of errors can usually be resolved by running mix clean. You may also see this type of error during Live code reload in dev. It case, try restarting the Phoenix.Server, and if that does not help, run mix clean

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Production deploy
Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Generate entities with Ecto
  * Run `mix phoenix.digest`      # Digests and compress static files
  * Run `mix phoenix.gen.channel` # Generates a Phoenix channel
  * Run `mix phoenix.gen.html`    # Generates controller, model and views for an HTML based resource
  * Run `mix phoenix.gen.json`    # Generates a controller and model for a JSON based resource
  * Run `mix phoenix.gen.model`   # Generates an Ecto model
  * Run `mix phoenix.gen.secret`  # Generates a secret
  * Run `mix phoenix.new`         # Create a new Phoenix v1.1.2 application
  * Run `mix phoenix.routes`      # Prints all routes
  * Run `mix phoenix.server`      # Starts applications and their servers

## Database migrations
  * Run `mix ecto.gen.migration add_password_hash_users`  # Add a new column to the exist table
  * Run `mix ecto.gen.migration`                          # Migrate database

## Learn more about Phoenix framework
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
