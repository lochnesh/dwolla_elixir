defmodule DwollaElixirTest do
  require DwollaElixir
  use ExUnit.Case

  test "should get key, secret, and token" do
    client = DwollaElixir.client(key: "key", secret: "secret", token: "token")
    assert client != nil 
    assert DwollaElixir.client(client, :key)  == "key"
    assert DwollaElixir.client(client, :secret)  == "secret"
    assert DwollaElixir.client(client, :token)  == "token"
  end

end
