# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cue.Repo.insert!(%Cue.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Cue.Rooms

# Just an empty room, not visitors yet
{:ok, _room_empty} =
  Rooms.create_room(%{
    name: "empty",
    target_url: "https://example.com/empty"
  })

# Room with some visitors, but no one admitted
{:ok, room_with_visitors} =
  Rooms.create_room(%{
    name: "with_visitors",
    target_url: "https://example.com/with_visitors"
  })

{:ok, _visitor_1} = Rooms.assign_number(room_with_visitors, Ecto.UUID.generate())
{:ok, _visitor_2} = Rooms.assign_number(room_with_visitors, Ecto.UUID.generate())
{:ok, _visitor_3} = Rooms.assign_number(room_with_visitors, Ecto.UUID.generate())
