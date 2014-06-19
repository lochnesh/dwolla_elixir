defmodule DwollaElixir.Users do
  import DwollaElixir.Client

  def get(id, client), do: get("users/#{id}", client(client, :key), client(client, :secret))
  def account(client), do: get_with_token("users/", client(client, :token))

end
