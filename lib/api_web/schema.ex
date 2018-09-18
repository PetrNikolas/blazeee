defmodule ApiWeb.Schema do
  use Absinthe.Schema
  import_types Absinthe.Type.Custom

  import_types ApiWeb.Schema.AccountTypes

  alias ApiWeb.Resolvers

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &Resolvers.Accounts.get_users/3
    end

    @desc "Get a user"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.find_user/3
    end
  end
end