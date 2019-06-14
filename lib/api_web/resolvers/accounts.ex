defmodule ApiWeb.Resolvers.Accounts do
  # Get all users  
  def get_users(_parent, _args, _resolution) do
    users = Api.Accounts.list_users()
    {:ok, users}
  end

  # Find user by ID
  def find_user(_parent, %{id: id}, _resolution) do
    case Api.Accounts.get_user!(id) do
      nil ->
        {:error, "User ID #{id} not found"}

      user ->
        {:ok, user}
    end
  end

  # Create user - sign up
  def create(params, _info) do
    Api.Accounts.create_user(params)
  end
end
