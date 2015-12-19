defmodule Releasebot.Stats do
  require EEx

  def aggregate(repos) do
    Enum.map(repos, fn({username, repo}) ->
      [repo: "#{username}/#{repo}", needs_release: Releasebot.Repo.needs_release?(username, repo)]
    end)
  end

  def pretty_print(repos) do
    str = ~S"""
    <%= if Enum.count(repos) > 0 do %>The following repos might need a release:

    <%= for item <- repos do %>https://github.com/<%= item[:repo] %>
    <% end %>
    <%= else %>No repo needs a release
    <% end %>
    """

    filtered = repos |> aggregate |> Enum.filter(fn(r) -> r[:needs_release] end)

    EEx.eval_string str, [repos: filtered]
  end
end
