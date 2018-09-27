defmodule ApiWeb.PageView do
  use ApiWeb, :view

  def render("index.json", %{}) do
    "The API is running successfully."
  end
end
