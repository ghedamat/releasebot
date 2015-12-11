use Mix.Config
config :releasebot, :slack,
  username: "releasebot",
  token: "",
  channel: ""

config :releasebot, :github,
  token: ""

config :releasebot, :repos,
  [
    "u/r",
    "d/f",
  ]
