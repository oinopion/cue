defmodule Cue.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rooms" do
    field :name, :string
    field :target_url, :string
    field :visitors_counter, :integer, default: 0
    field :last_admitted_number, :integer

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :target_url])
    |> validate_required([:name, :target_url])
  end
end
