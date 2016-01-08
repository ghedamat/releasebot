defmodule Releasebot.Stats do
  require EEx
  alias Releasebot.Repo

  def needs_release(repos) do
    str = ~S"""
    ---------
    <%= if Enum.count(repos) > 0 do %>The following repos might need a release:

    <%= for item <- repos do %>https://github.com/<%= item[:repo] %>
    <% end %>
    <%= else %>No repo needs a release
    <% end %>
    ---------
    """

    filtered = repos |> fetch_releases |> Enum.filter(fn(r) -> r[:needs_release] end)

    EEx.eval_string str, [repos: filtered]
  end

  def fetch_releases(repos) do
    repos
    |> Enum.map(fn({username, repo}) ->
      Task.async(fn -> [repo: "#{username}/#{repo}", needs_release: Repo.needs_release?(username, repo)] end)
    end)
    |> Enum.map(&Task.await(&1))
  end

  def open_prs(repos) do
    str = ~S"""
    ---------
    <%= if Enum.count(repos) > 0 do %>The following prs are open

    <%= for repo <- repos do %><%= for item <- repo do %>
    link: <%= item[:url] %>
    title: <%= item[:title] %>
    last update on: <%= item[:updated_at] %>
    <% end %><% end %>
    <%= else %>No repo has on open pr
    <% end %>
    ---------
    """

    filtered = repos |> fetch_pulls |> Enum.filter(fn(r) -> Enum.count(r) end)

    EEx.eval_string str, [repos: filtered]
  end

  def fetch_pulls(repos) do
    repos
    |> Enum.map(fn({username, repo}) ->
      Task.async(fn -> Repo.pulls(username, repo) end)
    end)
    |> Enum.map(&Task.await(&1))
  end
end
