defmodule Cue.RoomsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cue.Rooms` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        name: "some name",
        target_url: "some target_url"
      })
      |> Cue.Rooms.create_room()

    room
  end

  @doc """
  Generate a room_visitor.
  """
  def room_visitor_fixture(room, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        number: 42,
        visitor_id: "7488a646-e31f-11e4-aace-600308960662"
      })

    {:ok, room_visitor} = Cue.Rooms.create_room_visitor(room, attrs)
    room_visitor
  end
end
