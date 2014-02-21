defmodule DwollaElixir.Client.Base do
  use HTTPoison.Base
  require URI

  def get(url, key, secret) do
    HTTPoison.start
    HTTPoison.get "https://www.dwolla.com/oauth/rest/#{url}?client_id=#{URI.encode(key)}&client_secret=#{URI.encode(secret)}"
  end

end

