alias Cue.Repo
alias Cue.Rooms
alias Cue.Rooms.Room
alias Cue.Rooms.RoomVisitor

import Ecto.Query, warn: false

defmodule R do
  @doc """
  A helper for quick access to rooms defined in seeds.exs
  """

  def empty(), do: Rooms.get_room_by_name!("empty")
  def with_visitors(), do: Rooms.get_room_by_name!("with_visitors")
end
