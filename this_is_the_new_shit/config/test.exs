use Mix.Config

# Configure your database
config :this_is_the_new_shit, ThisIsTheNewShit.Repo,
  username: "postgres",
  password: "postgres",
  database: "this_is_the_new_shit_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :this_is_the_new_shit, ThisIsTheNewShitWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
