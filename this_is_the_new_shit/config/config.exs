# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :this_is_the_new_shit,
  ecto_repos: [ThisIsTheNewShit.Repo]

# Configures the endpoint
config :this_is_the_new_shit, ThisIsTheNewShitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9mBA71jD0y5bqChtR3DLJUEQKVxIpGg/PxHnoMt3dtlNpkOsW9f+A0+EFdJ9LbVP",
  render_errors: [view: ThisIsTheNewShitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ThisIsTheNewShit.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
