use Mix.Config

config :watchman,
  host: "0.0.0.0",
  port: 8125,
  prefix: "loghub.#{System.get_env("METRICS_NAMESPACE") || "dev"}"

config :secrets, http_port: 4000
