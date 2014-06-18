defmodule DwollaElixir.Client.Base do
  require URI

  def get(url, key, secret) do
    HTTPoison.get "https://www.dwolla.com/oauth/rest/#{url}?client_id=#{URI.encode(key)}&client_secret=#{URI.encode(secret)}"
  end

end

