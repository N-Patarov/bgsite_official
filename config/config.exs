# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bgsite_official,
  ecto_repos: [BgsiteOfficial.Repo]

# Configures the endpoint
config :bgsite_official, BgsiteOfficialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6ypYFH9J9vdKqj+pAHhzgGnpeo5VDZLbdWY9Xg5CkAMdWZ2907AqaxiKGYdBSzvA",
  render_errors: [view: BgsiteOfficialWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BgsiteOfficial.PubSub,
  live_view: [signing_salt: "ZGDyDgzZ"]

config :bgsite_official, MyApp.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "my_api_key"
    hackney_opts: [
    recv_timeout: :timer.minutes(1),
    connect_timeout: :timer.minutes(1)
    ]
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
