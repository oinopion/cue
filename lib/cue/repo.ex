defmodule Cue.Repo do
  use Ecto.Repo,
    otp_app: :cue,
    adapter: Ecto.Adapters.Postgres
end
