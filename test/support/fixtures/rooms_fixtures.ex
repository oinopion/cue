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
end
