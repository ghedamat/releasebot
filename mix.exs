defmodule Releasebot.Mixfile do
  use Mix.Project

  def project do
    [app: :releasebot,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript_config,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :eex, :httpotion, :exjsx, :tzdata, :tentacat]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:mock, "~> 0.1.1", only: :test},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:exjsx, "~> 3.0"},
      {:httpotion, "~> 2.1.0"},
      {:timex, "~> 1.0.0-rc4"},
      {:tzdata, "== 0.1.8", override: true},
      {:tentacat, path: "~/Dev/OSS/tentacat"}
    ]
  end

  defp escript_config do
    [ main_module: Releasebot.CLI ]
  end
end
