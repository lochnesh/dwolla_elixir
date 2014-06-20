defmodule DwollaElixir.Client do
  require Record
  require URI

  Record.defrecord :client, [key: nil, secret: nil, token: nil] 

  def get_with_key_secret(url, key, secret) do
    params = %{"client_id" => key, "client_secret" => secret} 
    response = HTTPoison.get "#{get_base_url()}#{url}?#{URI.encode_query params}"
    response.body |> JSON.decode!
  end

  def get_with_token(url, token) do
    params = %{"oauth_token" => token}
    response = HTTPoison.get "#{get_base_url()}#{url}?#{URI.encode_query params}"
    response.body |> JSON.decode!
  end
  
  def get(url) do
    HTTPoison.get "#{get_base_url()}#{url}"
  end

  def post(url, token, body) do
    params = %{"oauth_token" => token}
    json_body = JSON.encode!(body)
    response = HTTPoison.post "#{get_base_url()}#{url}?#{URI.encode_query params}", json_body, [{"Content-Type","application/json"}]
    response.body |> JSON.decode!
  end

  defp get_base_url(), do: elem(:application.get_env(:dwolla_elixir, :url), 1)

end

