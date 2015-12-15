use Mix.Config
config :releasebot, :slack,
  username: "releasebot",
  token: "",
  channel: ""

config :releasebot, :github,
  token: ""

config :releasebot, :cutoff_date,
  "2015-12-5"

config :releasebot, :repos,
  [
    "u/r",
    "d/f",
  ]
