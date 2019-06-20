defmodule Api.LogTest do
  use Api.DataCase

  alias Api.Log

  describe "events" do
    alias Api.Log.Events

    @valid_attrs %{
      event_type: "some event_type",
      message: "some message",
      payload: "some payload"
    }
    @update_attrs %{
      event_type: "some updated event_type",
      message: "some updated message",
      payload: "some updated payload"
    }
    @invalid_attrs %{event_type: nil, message: nil, payload: nil}

    def events_fixture(attrs \\ %{}) do
      {:ok, events} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Log.create_events()

      events
    end

    test "list_events/0 returns all events" do
      events = events_fixture()
      assert Log.list_events() == [events]
    end

    test "get_events!/1 returns the events with given id" do
      events = events_fixture()
      assert Log.get_events!(events.id) == events
    end

    test "create_events/1 with valid data creates a events" do
      assert {:ok, %Events{} = events} = Log.create_events(@valid_attrs)
      assert events.event_type == "some event_type"
      assert events.message == "some message"
      assert events.payload == "some payload"
    end

    test "create_events/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_events(@invalid_attrs)
    end

    test "update_events/2 with valid data updates the events" do
      events = events_fixture()
      assert {:ok, %Events{} = events} = Log.update_events(events, @update_attrs)
      assert events.event_type == "some updated event_type"
      assert events.message == "some updated message"
      assert events.payload == "some updated payload"
    end

    test "update_events/2 with invalid data returns error changeset" do
      events = events_fixture()
      assert {:error, %Ecto.Changeset{}} = Log.update_events(events, @invalid_attrs)
      assert events == Log.get_events!(events.id)
    end

    test "delete_events/1 deletes the events" do
      events = events_fixture()
      assert {:ok, %Events{}} = Log.delete_events(events)
      assert_raise Ecto.NoResultsError, fn -> Log.get_events!(events.id) end
    end

    test "change_events/1 returns a events changeset" do
      events = events_fixture()
      assert %Ecto.Changeset{} = Log.change_events(events)
    end
  end
end
