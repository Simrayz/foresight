# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :foresight, ForesightWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9zF7z7H6F2XIYrtn27HEVZAFskC7X2M1wGlFRYJWVlYTBXWkslOZBK5gC7Annhoe",
  render_errors: [view: ForesightWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Foresight.PubSub,
  live_view: [signing_salt: "5YH/pLzY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use Html5ever for HTML parsing in Floki
config :floki, :html_parser, Floki.HTMLParser.Html5ever

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
