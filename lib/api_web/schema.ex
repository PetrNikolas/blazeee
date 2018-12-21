defmodule ApiWeb.Schema do
  use Absinthe.Schema
  import_types Absinthe.Type.Custom

  import_types ApiWeb.Schema.AccountTypes

  alias ApiWeb.Resolvers

  query do
    @desc "Get all users"
    field :users, non_null(list_of(non_null(:user))) do
      resolve &Resolvers.Accounts.get_users/3
    end

    @desc "Get a user"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.find_user/3
    end

    @desc "Create a user - sign up"
    field :create_user, type: :user do
      arg(:first_name, non_null(:string))
      arg(:last_name, non_null(:string))
      arg(:username, non_null(:string))
      arg(:role, non_null(:integer))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))

      resolve(&Resolvers.Accounts.create/2)
    end
  end
end
