defmodule Allybot.Repo do
  use Ecto.Repo,
    otp_app: :allybot,
    adapter: Ecto.Adapters.Postgres
end
