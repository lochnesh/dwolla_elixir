defmodule DwollaElixir.Users do
  import DwollaElixir.Client

  def get(id, client), do: get_with_key_secret("users/#{id}", client(client, :key), client(client, :secret))
  def account(client), do: get_with_token("users/", client(client, :token))
  def avatar(dwolla_id), do: get("avatars/#{dwolla_id}")
  def nearby(latitude, longitude, client), do: get_with_key_secret("users/nearby", client(client, :key), client(client, :secret), %{"latitude" => latitude, "longitude" => longitude})

end
