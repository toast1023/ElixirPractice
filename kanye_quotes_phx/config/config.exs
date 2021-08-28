# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kanye_quotes_phx,
  ecto_repos: [KanyeQuotesPhx.Repo]

# Configures the endpoint
config :kanye_quotes_phx, KanyeQuotesPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2lCOtMT4qoSFuolUgkldbZqeoX705JIO0ocs0x23s98DzcQ3RCcvxrUhE+5jngm5",
  render_errors: [view: KanyeQuotesPhxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: KanyeQuotesPhx.PubSub,
  live_view: [signing_salt: "QXuyIKz0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
