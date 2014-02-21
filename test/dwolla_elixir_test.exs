defmodule DwollaElixirTest do
  use ExUnit.Case

  test "should get key, secret, and token" do
    client = DwollaElixir.Client.new(key: "key", secret: "secret", token: "token")
    assert client != nil 
    assert client.key == "key"
    assert client.secret == "secret"
    assert client.token == "token"  
  end

end
