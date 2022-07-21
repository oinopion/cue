defmodule Cue.RoomsTest do
  use Cue.DataCase, async: true

  alias Cue.Rooms

  describe "rooms" do
    alias Cue.Rooms.Room

    import Cue.RoomsFixtures

    @invalid_attrs %{name: nil, target_url: nil}

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Rooms.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Rooms.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room with no visitors" do
      valid_attrs = %{
        name: "some name",
        target_url: "some target_url"
      }

      assert {:ok, %Room{} = room} = Rooms.create_room(valid_attrs)
      assert room.name == "some name"
      assert room.target_url == "some target_url"
      assert room.visitors_counter == 0
      assert room.last_admitted_number == nil
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()

      update_attrs = %{
        name: "some updated name",
        target_url: "some updated target_url"
      }

      assert {:ok, %Room{} = room} = Rooms.update_room(room, update_attrs)
      assert room.name == "some updated name"
      assert room.target_url == "some updated target_url"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_room(room, @invalid_attrs)
      assert room == Rooms.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Rooms.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Rooms.change_room(room)
    end
  end

  describe "room_visitors" do
    alias Cue.Rooms.{Room, RoomVisitor}

    import Cue.RoomsFixtures

    @invalid_attrs %{number: nil, visitor_id: nil}

    setup do
      {:ok, room: room_fixture()}
    end

    test "list_room_visitors/0 returns all room_visitors for a room", %{room: room} do
      room_visitor = room_visitor_fixture(room)
      assert Rooms.list_room_visitors(room) |> Repo.preload(:room) == [room_visitor]
    end

    test " get_room_visitor!/2 returns the room_visitor with given id", %{room: room} do
      room_visitor = room_visitor_fixture(room)

      assert Rooms.get_room_visitor!(room, room_visitor.visitor_id) |> Repo.preload(:room) ==
               room_visitor
    end

    test "create_room_visitor/2 with valid data creates a room_visitor", %{room: room} do
      valid_attrs = %{number: 42, visitor_id: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %RoomVisitor{} = room_visitor} = Rooms.create_room_visitor(room, valid_attrs)
      assert room_visitor.number == 42
      assert room_visitor.visitor_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_room_visitor/2 with invalid data returns error changeset", %{room: room} do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_room_visitor(room, @invalid_attrs)
    end

    test "update_room_visitor/2 with valid data updates the room_visitor", %{room: room} do
      room_visitor = room_visitor_fixture(room)
      update_attrs = %{number: 43, visitor_id: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %RoomVisitor{} = room_visitor} =
               Rooms.update_room_visitor(room_visitor, update_attrs)

      assert room_visitor.number == 43
      assert room_visitor.visitor_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_room_visitor/2 with invalid data returns error changeset", %{room: room} do
      room_visitor = room_visitor_fixture(room)
      assert {:error, %Ecto.Changeset{}} = Rooms.update_room_visitor(room_visitor, @invalid_attrs)

      assert room_visitor ==
               Rooms.get_room_visitor!(room, room_visitor.visitor_id) |> Repo.preload(:room)
    end

    test "delete_room_visitor/1 deletes the room_visitor", %{room: room} do
      room_visitor = room_visitor_fixture(room)
      assert {:ok, %RoomVisitor{}} = Rooms.delete_room_visitor(room_visitor)

      assert_raise Ecto.NoResultsError, fn ->
        Rooms.get_room_visitor!(room, room_visitor.visitor_id)
      end
    end

    test "change_room_visitor/1 returns a room_visitor changeset", %{room: room} do
      room_visitor = room_visitor_fixture(room)
      assert %Ecto.Changeset{} = Rooms.change_room_visitor(room_visitor)
    end

    test "assign_number/2 creates a correct %RoomVisitor{}", %{room: room} do
      visitor_id = Ecto.UUID.generate()
      start = DateTime.utc_now()
      assert {:ok, %RoomVisitor{} = rv} = Rooms.assign_number(room, visitor_id)
      stop = DateTime.utc_now()

      assert rv.visitor_id == visitor_id
      assert rv.room_id == room.id
      assert rv.number > 0
      assert start <= rv.inserted_at <= stop
      assert rv.inserted_at == rv.updated_at
    end

    test "assign_number/2 updates room visitors_counter", %{room: room} do
      assert {:ok, %RoomVisitor{}} = Rooms.assign_number(room, Ecto.UUID.generate())
      room = Repo.get(Room, room.id)
      assert room.visitors_counter == 1

      assert {:ok, %RoomVisitor{}} = Rooms.assign_number(room, Ecto.UUID.generate())
      room = Repo.get(Room, room.id)
      assert room.visitors_counter == 2
    end

    test "assign_number/2 returns new %RoomVisitor{} with sequential numbers", %{room: room} do
      assert {:ok, %RoomVisitor{number: 1}} = Rooms.assign_number(room, Ecto.UUID.generate())
      assert {:ok, %RoomVisitor{number: 2}} = Rooms.assign_number(room, Ecto.UUID.generate())
    end

    test "assign_number/2 doesn't increment counter on repeated joins", %{room: room} do
      visitor_id = Ecto.UUID.generate()
      assert {:ok, _} = Rooms.assign_number(room, visitor_id)
      assert :error = Rooms.assign_number(room, visitor_id)
      room = Repo.get(Room, room.id)
      assert room.visitors_counter == 1
    end
  end
end
