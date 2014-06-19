defmodule UsersTest do 
  use ExUnit.Case
 
  import DwollaElixir.Client
  import Mock
  
  test "should get users by id" do 
    with_mock HTTPoison, [get: fn(_url) -> :ok end] do
      DwollaElixir.Users.get("reflector@dwolla.com", client(key: "key", secret: "secret"))  
      assert called HTTPoison.get("https://uat.dwolla.com/oauth/rest/users/reflector@dwolla.com?client_id=key&client_secret=secret")
    end
  end

  test "should get account with token" do
    with_mock HTTPoison, [get: fn(_url) -> :ok end] do
      DwollaElixir.Users.account(client(token: "token"))
      assert called HTTPoison.get("https://uat.dwolla.com/oauth/rest/users/?oauth_token=token")
    end
  end
   
  test "should get avatar for account id" do 
    with_mock HTTPoison, [get: fn(_url) -> :ok end] do
      DwollaElixir.Users.avatar("812-111-1111")
      assert called HTTPoison.get("https://uat.dwolla.com/oauth/rest/avatars/812-111-1111")    
    end
  end

  test "should get nearby for lat and long" do
    with_mock HTTPoison, [get: fn(_url) -> :ok end] do
      DwollaElixir.Users.nearby(6,6,client(key: "key", secret: "secret"))
      assert called HTTPoison.get("https://uat.dwolla.com/oauth/rest/users/nearby?client_id=key&client_secret=secret")
    end
  end
end
