# Blazeee

Elixir/Phoenix starter kit for modern development.

Version: 0.2.2

## Prerequisites

* [Elixir 1.7 or later](https://elixir-lang.org/)
* [Erlang 21 or later](https://www.erlang.org/)
* [Phoenix framework](https://phoenixframework.org/)
* [Node.js (>= 8.0.0)](https://nodejs.org/en/)
* [PostgreSQL](https://www.postgresql.org/)

## Libs

* [Absinthe](https://github.com/absinthe-graphql/absinthe)
* [Bcrypt](https://github.com/riverrun/bcrypt_elixir)
* [Corsica](https://github.com/whatyouhide/corsica)
* [Comeonin](https://github.com/riverrun/comeonin)
* [Guardian](https://github.com/ueberauth/guardian)
* [Credo](https://github.com/rrrene/credo)
* [Poison](https://github.com/devinus/poison)
* [LogViewer](https://github.com/shufo/log_viewer)
* [httpoison](https://github.com/edgurgel/httpoison)
* [GitHooks](https://github.com/qgadrian/elixir_git_hooks)
* [excoveralls](https://github.com/parroty/excoveralls)
* [ex_machina](https://github.com/thoughtbot/ex_machina)
* [ex_doc](https://github.com/elixir-lang/ex_doc)

## Setup project

To start your Phoenix server:

* Install dependencies with `mix deps.get`.
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`.
* Start Phoenix app with `mix phx.server` or you can also run your app inside IEx (Interactive Elixir) with `iex -S mix phx.server`.

NOTE: These types of errors can usually be resolved by running mix clean. You may also see this type of error during Live code reload in dev. It case, try restarting the Phoenix.Server, and if that does not help, run mix clean.

* Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
* Log Viewer is avalaible on [`localhost:5900`](http://localhost:5900).

## Production deploy

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Generate entities with Ecto

```sh
# Digests and compress static files
mix phx.digest

# Generates a Phoenix channel
mix phx.gen.channel

# Generates controller, model and views for an HTML based resource
mix phx.gen.html

# Generates a controller and model for a JSON based resource
mix phx.gen.json

# Generates an Ecto model
mix phx.gen.model

# Generates a secret
mix phx.gen.secret

# Create a new Phoenix application
mix phx.new

# Prints all routes
mix phx.routes

# Starts applications and their servers
mix phx.server
```

## Database migrations

```sh
# Add a new column to the exist table
mix ecto.gen.migration add_password_hash_users

# Migrate database
mix ecto.gen.migration
```

### Database seeds

```sh
# Add/seed data to the database
mix run priv/repo/seeds.exs
```

Or you can run `mix ecto.setup` for setup all process.

## Tests

```sh
# Run tests
mix test
```

## Code formatter

* You can run code formatter with `mix format`.

## Code analysis with Credo

* To run credo in the current project, just type: `mix credo`. This will run the code analysis and suggest places to edit your code.
* If you want to enforce a style guide and need a more traditional linting experience, try `mix credo --strict` and continue reading in the Configuration section.

## GraphQL

* Navigate to `localhost:4000/api/v1/graphiql`.
* You should be greeted with a pretty prompt for running graphql queries on the left, with responses on the right.
* In the top right, click “Docs” to inspect your API.

## CI/CD

You can use Gitlab CI or Travis CI (both files are here - in root of project).

## Documentation

* You can see [DOCUMENTATION](./DOCUMENTATION.md).

### Generated doc for your app

* Run `mix docs` and view them at "doc/index.html".

## Learn more about Phoenix framework

* Official website: [http://www.phoenixframework.org/](http://www.phoenixframework.org/)
* Guides: [http://phoenixframework.org/docs/overview](http://phoenixframework.org/docs/overview)
* Docs: [https://hexdocs.pm/phoenix](https://hexdocs.pm/phoenix)
* Mailing list: [http://groups.google.com/group/phoenix-talk](http://groups.google.com/group/phoenix-talk)
* Source: [https://github.com/phoenixframework/phoenix](https://github.com/phoenixframework/phoenix)
