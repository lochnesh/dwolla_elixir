defmodule DwollaElixir.Client do
  require Record
  require URI

  Record.defrecord :client, [key: nil, secret: nil, token: nil] 

  def get(url, key, secret) do
    HTTPoison.get "#{get_base_url()}#{url}?client_id=#{URI.encode(key)}&client_secret=#{URI.encode(secret)}"
  end

  defp get_base_url(), do: elem(:application.get_env(:dwolla_elixir, :url), 1)

end

