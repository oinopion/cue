defmodule Cue.Rooms.RoomVisitor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @foreign_key_type :binary_id
  schema "room_visitors" do
    field :visitor_id, :binary_id, primary_key: true
    field :number, :integer

    belongs_to :room, Cue.Rooms.Room, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(room_visitor, attrs) do
    room_visitor
    |> cast(attrs, [:visitor_id, :number])
    |> validate_required([:visitor_id, :number])
    |> validate_number(:number, greater_than: 0)
  end
end
