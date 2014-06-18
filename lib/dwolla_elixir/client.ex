defmodule DwollaElixir.Client do
  require Record
  require URI

  Record.defrecord :client, [key: nil, secret: nil, token: nil] 

  def get(url, key, secret) do
    HTTPoison.get "https://www.dwolla.com/oauth/rest/#{url}?client_id=#{URI.encode(key)}&client_secret=#{URI.encode(secret)}"
  end

end

