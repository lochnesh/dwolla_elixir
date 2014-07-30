defmodule FundingSourcesTest do 
  use ExUnit.Case
 
  import Dwolla.Client
  import Mock
  import EmptyHttp
  
  test "should list funding sources" do 
    with_mock HTTPoison, [get: fn(_url) -> empty_response() end] do
      Dwolla.FundingSources.list(client(token: "token"))  
      assert called HTTPoison.get("https://uat.dwolla.com/oauth/rest/fundingsources/?oauth_token=token")
    end
  end

end
