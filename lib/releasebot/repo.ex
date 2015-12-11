defmodule Releasebot.Repo do
  def needs_release?(repo) do
    c = diff(repo, start_tag(repo)) |> length
    c > 0
  end

  def start_tag(repo) do
    Request.get("https://api.github.com/repos/#{repo}/releases/latest", [], token)
    |> Dict.get("tag_name")
  end

  def diff(repo, start_tag, end_tag \\ "master") do
    Request.get("https://api.github.com/repos/#{repo}/compare/#{start_tag}...#{end_tag}", [], token)
    |> Dict.get("commits")
    |> Enum.map( fn(c) -> c["commit"]["message"] end)
    |> Enum.filter( fn(c) -> !Regex.match?(~r/Merge pull request #|\[DOC\]/, c) end)
  end

  def token do
    cfg = Application.get_env(:releasebot, :github)
    api_token = cfg[:token]
    [{"Authorization", "token #{api_token}"}]
  end

end
