defmodule Releasebot.Notify do
  def needs_release do
    Application.get_env(:releasebot, :repos)
    |> Releasebot.Stats.needs_release
    |> Releasebot.Slack.post_message
  end

  def open_prs do
    Application.get_env(:releasebot, :repos)
    |> Releasebot.Stats.open_prs
    |> Releasebot.Slack.post_message
  end
end
