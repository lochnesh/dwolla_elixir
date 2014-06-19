defmodule DwollaElixir.Client do
  require Record
  require URI

  Record.defrecord :client, [key: nil, secret: nil, token: nil] 

  def get_with_key_secret(url, key, secret) do
    response = HTTPoison.get "#{get_base_url()}#{url}?client_id=#{URI.encode(key)}&client_secret=#{URI.encode(secret)}"
    response.body |> JSON.decode!
  end

  def get_with_token(url, token) do
    response = HTTPoison.get "#{get_base_url()}#{url}?oauth_token=#{URI.encode(token)}"
    response.body |> JSON.decode!
  end
  
  def get(url) do
    HTTPoison.get "#{get_base_url()}#{url}"
  end

  def post(url, token, body) do
    json_body = JSON.encode!(body)
    response = HTTPoison.post "#{get_base_url()}#{url}?oauth_token=#{URI.encode(token)}", json_body, [{"Content-Type","application/json"}]
    response.body |> JSON.decode!
  end

  defp get_base_url(), do: elem(:application.get_env(:dwolla_elixir, :url), 1)

end

