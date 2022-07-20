defmodule Cue.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :target_url, :string
      add :visitors_counter, :integer, default: 0, null: false
      add :last_admitted_number, :integer

      timestamps()
    end
  end
end
