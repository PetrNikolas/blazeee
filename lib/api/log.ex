defmodule Api.Log do
  @moduledoc """
  The Log context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Log.Events

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Events{}, ...]

  """
  def list_events do
    Repo.all(Events)
  end

  @doc """
  Gets a single events.

  Raises `Ecto.NoResultsError` if the Events does not exist.

  ## Examples

      iex> get_events!(123)
      %Events{}

      iex> get_events!(456)
      ** (Ecto.NoResultsError)

  """
  def get_events!(id), do: Repo.get!(Events, id)

  @doc """
  Creates a events.

  ## Examples

      iex> create_events(%{field: value})
      {:ok, %Events{}}

      iex> create_events(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events(attrs \\ %{}) do
    %Events{}
    |> Events.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a events.

  ## Examples

      iex> update_events(events, %{field: new_value})
      {:ok, %Events{}}

      iex> update_events(events, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events(%Events{} = events, attrs) do
    events
    |> Events.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Events.

  ## Examples

      iex> delete_events(events)
      {:ok, %Events{}}

      iex> delete_events(events)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events(%Events{} = events) do
    Repo.delete(events)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events changes.

  ## Examples

      iex> change_events(events)
      %Ecto.Changeset{source: %Events{}}

  """
  def change_events(%Events{} = events) do
    Events.changeset(events, %{})
  end
end
