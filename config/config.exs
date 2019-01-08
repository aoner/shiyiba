# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sky,
  ecto_repos: [Sky.Repo]

# Configures the endpoint
config :sky, SkyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+SQ00Mr9p3s/BQwkh598COUFhCQQQr1apimwgOZkWCmaUg9rnOib25LygSSqoMTA",
  render_errors: [view: SkyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sky.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :arc,
  storage: Arc.Storage.Local

config :phoenix, 
  json_library: Poison

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
