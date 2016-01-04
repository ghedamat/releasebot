defmodule Releasebot.Notify do
  def send_notification do
    Application.get_env(:releasebot, :repos)
    |> Releasebot.Stats.needs_release
    |> Releasebot.Slack.post_message
  end

  def send_prs do
    Application.get_env(:releasebot, :repos)
    |> Releasebot.Stats.open_prs
  end
end
