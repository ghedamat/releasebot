# Releasebot

A very simple elixir script to monitor npm repositories that might need a release.

## How it works

```
./releasebot
```

Every time the script runs it will check each of the repositories listed in the environment config, try to determine which ones need a new release and notify a slack channel.

## Config format

```
# config/dev.exs

config :releasebot, :slack,
  username: "releasebot",
  token: "XXX",
  channel: "CXXX"
  
config :releasebot, :github,
  token: "XXX",

config :releasebot, :repos,
  [
    "ember-cli-deploy/ember-cli-deploy-lightning-pack",
    "ember-cli-deploy/ember-cli-deploy-ssh-tunnel",
    "ember-cli-deploy/ember-cli-deploy-redis",
    "ember-cli-deploy/ember-cli-deploy-slack",
    "ember-cli-deploy/ember-cli-deploy-s3-index",
    "ember-cli-deploy/ember-cli-deploy-display-revisions",
    "ember-cli-deploy/ember-cli-deploy-json-config",
    "ember-cli-deploy/ember-cli-deploy-s3",
    "ember-cli-deploy/ember-cli-deploy-manifest",
    "ember-cli-deploy/ember-cli-deploy-gzip",
    "ember-cli-deploy/ember-cli-deploy-build",
    "ember-cli-deploy/ember-cli-deploy-revision-data",
    "ember-cli-deploy/ember-cli-deploy-plugin"
  ]
```

## `Needs release?` Strategy
Uses GH api to list commits between latest release and master excluding merge commits and [DOC] commits.

If there are commits left, a release is needed.

## Build

```
mix escript.build
```
