defmodule Releasebot.Notify do
  def send_notification do
    Application.get_env(:releasebot, :repos)
    |> Releasebot.Stats.pretty_print
    |> Releasebot.Slack.post_message
  end
end
