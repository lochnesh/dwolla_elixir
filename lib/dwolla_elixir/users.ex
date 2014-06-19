defmodule DwollaElixir.Users do
  import DwollaElixir.Client

  def get(id, client), do: get_with_key_secret("users/#{id}", client(client, :key), client(client, :secret))
  def account(client), do: get_with_token("users/", client(client, :token))
  def avatar(dwolla_id), do: get("avatars/#{dwolla_id}")

end
