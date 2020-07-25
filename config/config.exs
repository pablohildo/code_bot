import Config

config :nostrum,
  token: System.get_env("DISCORD_TOKEN"),
  num_shards: 1

config :code_bot,
  token: System.get_env("GLOT_TOKEN")
