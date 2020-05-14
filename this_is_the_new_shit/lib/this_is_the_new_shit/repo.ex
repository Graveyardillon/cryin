defmodule ThisIsTheNewShit.Repo do
  use Ecto.Repo,
    otp_app: :this_is_the_new_shit,
    adapter: Ecto.Adapters.Postgres
end
