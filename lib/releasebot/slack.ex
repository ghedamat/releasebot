defmodule Releasebot.Slack do
  @base_url "https://slack.com/api/"

  def post_message(text) do
    method = "chat.postMessage"
    cfg = Application.get_env(:releasebot, :slack)
    api_token = cfg[:token]
    channel = cfg[:channel]
    username = cfg[:username]
    params = [token: api_token, channel: channel, text: text, username: username]
    HTTPotion.get build_url(method, params)
  end

  def build_url(method, params) do
    base = "#{@base_url}#{method}?"
    params = Enum.map(params, fn(p) ->
      {k, v} = p
      "#{Atom.to_string(k)}=#{v}"
    end) |> Enum.join("&")
    base <> params |> URI.encode
  end
end
