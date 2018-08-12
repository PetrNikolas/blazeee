defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :role, :integer
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :username, :password, :role])
    |> validate_required([:first_name, :last_name, :email, :username, :password, :role])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
