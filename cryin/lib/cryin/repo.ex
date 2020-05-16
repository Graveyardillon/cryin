defmodule Cryin.Repo do
  use Ecto.Repo,
    otp_app: :cryin,
    adapter: Ecto.Adapters.Postgres
end
