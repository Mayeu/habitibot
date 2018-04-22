# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :habitibot_web, namespace: HabitibotWeb

# Configures the endpoint
config :habitibot_web, HabitibotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x+rEmuQUGi4/Y8GAoiAXlVBFV0NIsrZszIZK1NsGixh/xfEsUEKplqQuTvH2ZVep",
  render_errors: [view: HabitibotWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HabitibotWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :habitibot_web, :generators, context_app: :habitibot

# No ecto here
config :habitibot_web, ecto_repos: []

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
