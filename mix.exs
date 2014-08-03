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

  defp deps do
    [
      {:json, "~> 0.3.0"},
      {:httpoison, "~> 0.3"},
      {:hackney, github: "benoitc/hackney", tag: "0.13.0"},
      {:mock, github: "lochnesh/mock"}
    ]
  end
end
