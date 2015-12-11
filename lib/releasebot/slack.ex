defmodule Releasebot.Slack do
  @base_url "https://slack.com/api/"

  def post_message(text) do
    method = "chat.postMessage"
    cfg = Application.get_env(:releasebot, :slack)
    api_token = cfg[:token]
    channel = cfg[:channel]
    username = cfg[:username]
    params = [token: api_token, channel: channel, text: text, username: username]
    base = "#{@base_url}#{method}"
    Request.get(base, params)
  end
end
