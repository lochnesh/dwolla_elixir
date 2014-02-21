defmodule Users do
  import DwollaElixir.Client.Base
  alias DwollaElixir.Client

  def get(id) do
    get "/users/#{id}", 
    "key", 
    "secret"
  end
end
