use Mix.Config
config :releasebot, :slack,
  username: "releasebot",
  token: "",
  channel: ""

config :releasebot, :repos,
  [
    "u/r",
    "d/f",
  ]
