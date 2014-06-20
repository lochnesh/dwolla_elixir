defmodule Dwolla.Client do
  require Record
  require URI

  Record.defrecord :client, [
    key: Application.get_env(:dwolla_elixir, :key, System.get_env("KEY")),
    secret: Application.get_env(:dwolla_elixir, :secret, System.get_env("SECRET")),
    token: Application.get_env(:dwolla_elixir, :token, System.get_env("TOKEN")),
  ] 

  def new, do: client() 

  def get_with_key_secret(url, key, secret, params \\ %{}) do
    params = Enum.concat %{"client_id" => key, "client_secret" => secret}, params 
    response = HTTPoison.get "#{get_base_url()}#{url}?#{URI.encode_query params}"
    response.body |> JSON.decode!
  end

  def get_with_token(url, token, params \\ %{}) do
    params = Enum.concat %{"oauth_token" => token}, params
    response = HTTPoison.get "#{get_base_url()}#{url}?#{URI.encode_query params}"
    response.body |> JSON.decode!
  end
  
  def get(url) do
    HTTPoison.get "#{get_base_url()}#{url}"
  end

  def post(url, token, body, params \\ %{}) do
    params = Enum.concat %{"oauth_token" => token}, params
    json_body = JSON.encode!(body)
    response = HTTPoison.post "#{get_base_url()}#{url}?#{URI.encode_query params}", json_body, [{"Content-Type","application/json"}]
    response.body |> JSON.decode!
  end

  defp get_base_url(), do: Application.get_env(:dwolla_elixir, :url)
end
