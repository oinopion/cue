defmodule Cue.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Cue.Repo

  alias Cue.Rooms.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{data: %Room{}}

  """
  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  alias Cue.Rooms.RoomVisitor

  @doc """
  Returns the list of room_visitors for a given room.

  ## Examples

      iex> list_room_visitors(room)
      [%RoomVisitor{}, ...]

  """
  def list_room_visitors(%Room{id: room_id}) do
    Repo.all(from rv in RoomVisitor, where: rv.room_id == ^room_id)
  end

  @doc """
  Gets a single room_visitor.

  Raises `Ecto.NoResultsError` if the Room visitor does not exist.

  ## Examples

      iex> get_room_visitor!(room, 123)
      %RoomVisitor{}

      iex> get_room_visitor!(room, 456)
      ** (Ecto.NoResultsError)

  """
  def get_room_visitor!(%Room{id: room_id}, visitor_id) do
    Repo.get_by!(RoomVisitor, room_id: room_id, visitor_id: visitor_id)
  end

  @doc """
  Creates a room_visitor for a given room.

  ## Examples

      iex> create_room_visitor(room, %{field: value})
      {:ok, %RoomVisitor{}}

      iex> create_room_visitor(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room_visitor(%Room{} = room, attrs \\ %{}) do
    %RoomVisitor{}
    |> RoomVisitor.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:room, room)
    |> Repo.insert()
  end

  @doc """
  Updates a room_visitor.

  ## Examples

      iex> update_room_visitor(room_visitor, %{field: new_value})
      {:ok, %RoomVisitor{}}

      iex> update_room_visitor(room_visitor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room_visitor(%RoomVisitor{} = room_visitor, attrs) do
    room_visitor
    |> RoomVisitor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room_visitor.

  ## Examples

      iex> delete_room_visitor(room_visitor)
      {:ok, %RoomVisitor{}}

      iex> delete_room_visitor(room_visitor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room_visitor(%RoomVisitor{} = room_visitor) do
    Repo.delete(room_visitor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room_visitor changes.

  ## Examples

      iex> change_room_visitor(room_visitor)
      %Ecto.Changeset{data: %RoomVisitor{}}

  """
  def change_room_visitor(%RoomVisitor{} = room_visitor, attrs \\ %{}) do
    RoomVisitor.changeset(room_visitor, attrs)
  end
end
