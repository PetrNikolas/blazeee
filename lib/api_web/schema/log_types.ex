defmodule ApiWeb.Schema.LogTypes do
  use Absinthe.Schema.Notation

  @desc "A event"
  object :event do
    field :id, :id
    field :event_type, :string
    field :message, :string
    field :payload, :string
  end
end
