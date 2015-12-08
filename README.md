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
For each repository the HEAD SHA will be compared with the SHAs found in the tag list.

If the SHA is not found then the repo **might** need a release.

**TODO:** this logic should be improved

## Build

```
mix escript.build
```
