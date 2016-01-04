defmodule Releasebot.Stats do
  require EEx
  alias Releasebot.Repo

  def needs_release(repos) do
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

  def open_prs(repos) do
    str = ~S"""
    <%= if Enum.count(repos) > 0 do %>The following prs are open:

    <%= for repo <- repos do %><%= for item <- repo do %>
    <%= item[:url] %> #<%= item[:number] %> <%= item[:title] %>
    last update on: <%= item[:updated_at] %>
    <% end %><% end %>
    <%= else %>No repo has on open pr
    <% end %>
    """

    filtered = repos
                |> Enum.map(fn({username, repo}) -> Repo.pulls(username, repo) end)
                |> Enum.filter(fn(r) -> Enum.count(r) end)

    EEx.eval_string str, [repos: filtered]
  end

  defp aggregate(repos) do
    Enum.map(repos, fn({username, repo}) ->
      [repo: "#{username}/#{repo}", needs_release: Repo.needs_release?(username, repo)]
    end)
  end
end
