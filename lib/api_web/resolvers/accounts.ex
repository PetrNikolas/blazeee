defmodule ApiWeb.Resolvers.Accounts do 
  def get_users(_parent, _args, _resolution) do
    case Api.Accounts.list_users() do
      nil ->
        {:error, "Users are not available."}
      users ->
        {:ok, users}
    end
  end

  def find_user(_parent, %{id: id}, _resolution) do
    case Api.Accounts.get_user!(id) do
      nil ->
        {:error, "User ID #{id} not found"}
      user ->
        {:ok, user}
    end
  end
end