import Config

config :nostrum,
  token: System.get_env("DISCORD_TOKEN"),
  num_shards: 1
