defmodule Cue.Repo.Migrations.CreateRoomVisitors do
  use Ecto.Migration

  def change do
    create table(:room_visitors, primary_key: false) do
      add :visitor_id, :binary_id, primary_key: true

      add :room_id, references(:rooms, on_delete: :delete_all, type: :binary_id),
        primary_key: true

      add :number, :integer, null: false

      timestamps()
    end

    create unique_index(:room_visitors, [:room_id, :number])
  end
end
