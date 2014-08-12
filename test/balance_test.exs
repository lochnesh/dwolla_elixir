defmodule BalanceTest do 
  use ExUnit.Case
 
  import Dwolla.Client
  import Mock
  import EmptyHttp
  
  test "should get balance" do 
    with_mock HTTPoison, [get: fn(_url) -> empty_response() end] do
      Dwolla.Balance.get(client(token: "token"))  
      assert called HTTPoison.get("https://uat.dwolla.com/oauth/rest/balance/?oauth_token=token")
    end
  end

end
