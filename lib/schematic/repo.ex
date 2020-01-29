defmodule Schematic.Repo do
  use Ecto.Repo,
    otp_app: :schematic,
    adapter: Ecto.Adapters.Postgres
end
