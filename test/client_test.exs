defmodule ClientTest do
  use ExUnit.Case
  import Dwolla.Client

  test "should get key, secret, and token" do
    client = client(key: "key", secret: "secret", token: "token")
    assert client != nil 
    assert client(client, :key)  == "key"
    assert client(client, :secret)  == "secret"
    assert client(client, :token)  == "token"
  end

end
