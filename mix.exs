defmodule DwollaElixir.Mixfile do
  use Mix.Project

  def project do
    [ app: :dwolla_elixir,
      version: "0.0.1",
      elixir: "~> 0.14.0",
      test_paths: test_paths(Mix.env),
      deps: deps
      ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { DwollaElixir, [] }, 
      applications: [:httpoison],
      env: [url: "https://www.dwolla.com/oauth/rest/"]
    ]
  end

  #set MIX_ENV=all or do not set
  #integration tests require env variables with client key and secret
  defp test_paths(:all), do: ["test", "integration_test"] 
  defp test_paths(_), do: ["test"]

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:json, github: "cblage/elixir-json"},
      {:httpoison, github: "edgurgel/httpoison"},
      {:mock, github: "lochnesh/mock"}
    ]
  end
end
