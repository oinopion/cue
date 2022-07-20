defmodule Cue.Rooms.RoomVisitor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @foreign_key_type :binary_id
  schema "room_visitors" do
    field :room_id, :binary_id, primary_key: true
    field :visitor_id, :binary_id, primary_key: true
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(room_visitor, attrs) do
    room_visitor
    |> cast(attrs, [:visitor_id, :room_id, :number])
    |> validate_required([:visitor_id, :room_id, :number])
  end
end
