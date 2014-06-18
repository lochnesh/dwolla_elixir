defmodule DwollaElixir.Users do
  import DwollaElixir.Client

  def get(id, client) do
    get "/users/#{id}", 
    client(client, :key), 
    client(client, :secret)
  end
end
