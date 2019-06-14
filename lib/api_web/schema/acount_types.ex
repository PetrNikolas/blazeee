defmodule ApiWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  @desc "A user"
  object :user do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :role, :integer
  end
end
