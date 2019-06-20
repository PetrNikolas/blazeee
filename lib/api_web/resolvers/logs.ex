defmodule ApiWeb.Resolvers.Logs do
  # Get all events  
  def get_events(_parent, _args, _resolution) do
    events = Api.Log.list_events()
    {:ok, events}
  end
end
