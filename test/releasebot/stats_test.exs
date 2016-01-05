defmodule Releasebot.StatsTest do
  use ExUnit.Case, async: false
  doctest Releasebot

  import Releasebot.Stats
  import Mock

  test_with_mock "aggregates stats for multiple repos", Releasebot.Repo, [needs_release?: fn(_) -> true end] do
    repos = ["u/r", "d/f"]
    assert aggregate(repos) == [
      [repo: "u/r", needs_release: true],
      [repo: "d/f", needs_release: true]
    ]
  end

  test_with_mock "prints a nice report", Releasebot.Repo, [needs_release?: fn(_) -> true end] do
    repos = ["u/r", "d/f"]
    result = ~s"""
    The following repos might need a release:

    https://github.com/u/r
    https://github.com/d/f


    """
    assert needs_release(repos) == result
  end

  test_with_mock "can tell if no repo needs a release", Releasebot.Repo, [needs_release?: fn(_) -> false end] do
    repos = ["u/r", "d/f"]
    result = ~s"""
    No repo needs a release

    """
    assert needs_release(repos) == result
  end

  test_with_mock "includes only repos that need a release", Releasebot.Repo, [needs_release?: fn(r) ->
                                                                                                if r == "u/r" do
                                                                                                  true
                                                                                                else
                                                                                                  false
                                                                                                end
                                                                                              end] do
    repos = ["u/r", "d/f"]
    result = ~s"""
    The following repos might need a release:

    https://github.com/u/r


    """
    assert needs_release(repos) == result
  end
end
