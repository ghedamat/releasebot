defmodule Releasebot.Repo do
  use Timex

  def needs_release?(username, repo) do
    c = diff(username, repo, start_tag(username, repo)) |> length
    c > 0
  end

  def start_tag(username, repo) do
    Tentacat.Releases.find("latest", username, repo, client)
    |> Dict.get("tag_name")
  end

  def diff(username, repo, start_tag, end_tag \\ "master") do
    Tentacat.Commits.compare(start_tag, end_tag, username, repo, client)
    |> Dict.get("commits")
    |> Enum.filter( &is_after_cutoff_date?/1 )
    |> Enum.map(fn(c) -> c["commit"]["message"] end)
    |> Enum.filter(fn(c) -> !Regex.match?(~r/Merge pull request #|\[DOC\]/, c) end)
  end

  def is_after_cutoff_date?(commit) do
    {:ok, date} = commit["commit"]["committer"]["date"] |> DateFormat.parse("{ISO}")
    {:ok, cutoff_date} = Application.get_env(:releasebot, :cutoff_date) |> DateFormat.parse("{YYYY}-{0M}-{0D}")
    Date.compare(cutoff_date, date) < 0
  end

  def client do
    cfg = Application.get_env(:releasebot, :github)
    api_token = cfg[:token]
    Tentacat.Client.new(%{access_token: api_token})
  end

end
