defmodule WorktimeServer.Repo do
  use Ecto.Repo,
    otp_app: :worktime_server,
    adapter: Ecto.Adapters.Postgres
end
