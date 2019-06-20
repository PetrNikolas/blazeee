defmodule Api.Log.Events do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :event_type, :string
    field :message, :string
    field :payload, :string

    timestamps()
  end

  @doc false
  def changeset(events, attrs) do
    events
    |> cast(attrs, [:event_type, :message, :payload])
    |> validate_required([:event_type, :message, :payload])
  end
end
