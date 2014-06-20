defmodule Dwolla.Users do
  import Dwolla.Client
 
  @moduledoc """
  A wrapper for Users end points in the Dwolla API
  """

  @doc "https://developers.dwolla.com/dev/docs/users/basic"
  def get(id, client), do: get_with_key_secret("users/#{id}", client(client, :key), client(client, :secret))

  @doc "https://developers.dwolla.com/dev/docs/users/account"
  def account(client), do: get_with_token("users/", client(client, :token))

  @doc "https://developers.dwolla.com/dev/docs/users/avatar" 
  def avatar(dwolla_id), do: get("avatars/#{dwolla_id}")

  @doc "https://developers.dwolla.com/dev/docs/users/nearby"
  def nearby(latitude, longitude, client), do: get_with_key_secret("users/nearby", client(client, :key), client(client, :secret), %{"latitude" => latitude, "longitude" => longitude})

end
