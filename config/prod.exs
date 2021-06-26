use Mix.Config

config :bgsite_official, BgsiteOfficial.Endpoint,
  url: [host: "example.com", port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json"# Do not print debug messages in production
config :logger, level: :info# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :bgsite_official, BgsiteOfficialWeb.Endpoint, server: true
