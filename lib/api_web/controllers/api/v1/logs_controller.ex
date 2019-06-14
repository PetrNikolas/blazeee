defmodule ApiWeb.Api.V1.LogsController do
  use ApiWeb, :controller

  def index(conn, %{"text" => text} = params) do
    body = %{
      text: text,
      channel: "#YOUR-CHANNEL"
    }

    with {:ok, body} do
      conn
      |> send_log_to_slack(body)
      |> json(body)
    else
      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> render(%{errors: errors})
    end
  end

  # Metho for send log to Slack channel
  def send_log_to_slack(conn, body) do
    webhook_url = "https://hooks.slack.com/services/YOUR-URL-TOKEN"

    headers = [
      {"Content-Type", "application/json; charset=utf-8"},
      {"Accept", "application/json"},
      {"Access-Control-Allow-Origin", "*"}
    ]

    {:ok, body} = Poison.encode(body)

    HTTPoison.post(webhook_url, body, headers)
  end
end
