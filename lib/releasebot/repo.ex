defmodule Releasebot.Repo do
  def needs_release?(repo) do
    url = build_url(repo)
    tags = get_tags(url)
    head = get_head(url)
    !(Enum.member?(tags, head))
  end

  def get_tags(url) do
    {out, status} = System.cmd("git", ["ls-remote", "--tags", url])
    if status != 0 do
      raise "git ls-remote failed"
    end
    out |> String.split
  end

  def get_head(url) do
    {out, status} = System.cmd("git", ["ls-remote", url, "master"])
    if status != 0 do
      raise "git ls-remote failed"
    end
    out |> String.split |> List.first
  end

  defp build_url(repo) do
    "https://github.com/#{repo}"
  end
end

#git ls-remote --tags https://github.com/ember-cli-deploy/ember-cli-deploy-plugin | grep $(git ls-remote https://github.com/ember-cli-deploy/ember-cli-deploy-plugin master | cut -f 1)`
