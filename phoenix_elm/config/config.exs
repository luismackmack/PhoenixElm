# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_elm,
  ecto_repos: [PhoenixElm.Repo]

# Configures the endpoint
config :phoenix_elm, PhoenixElm.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1v8rS0+Z8coNNeAOAYJjKKIm5/p/PbgCyA6DLjj8DRSRmDMGxUI4pi59JVeRXMzy",
  render_errors: [view: PhoenixElm.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixElm.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the Guardian dep
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  verify_issuer: true, # optional
  issuer: "PhoenixElm",
  ttl: { 30, :days },
  # ttl: { 15, :seconds }, # Just an easy way to test api key expiration 'for realz'
  secret_key: "9ZH-avLYkRnL2RxqsBXHS2NZe6ki37bp1pdekUcgpCyHqHDzTfqPCzE2oIA_4tLAD_gEQLaSpv1tQwfy_yJNrKrd7PpD-4V1OtLBSPhnTvr2eYXxp4mycen2FYkOnpvKsdtxUv8mvWPa3LJDUTHrF8mDhhSOIIvDVt2Agzf4A4wiAQxCG5-qGPuSQfTf87qcC9a8au5xJndMBDKG37KNzTmw87pKsC5dn3F9ZjgM1E1cKEYbHhQGU3HxYA-_zvO1eKWfg1ictaHy7lbKA3jq-zp-upUzdU2Rv_Qbocfg_5d2K9dmXyTVuFfgGGxa8N1tNhNfWs5zG6vySFenCLBghg",
  serializer: PhoenixElm.GuardianSerializer




# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
