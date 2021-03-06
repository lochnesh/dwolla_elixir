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

  test "should get funding source details" do 
    with_mock HTTPoison, [get: fn(_url) -> empty_response() end] do
      Dwolla.FundingSources.get_by_id("1", client(token: "token"))
      assert called HTTPoison.get("https://uat.dwolla.com/oauth/rest/fundingsources/1?oauth_token=token")
    end
  end

  test "should deposit" do 
    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> empty_response() end] do
      body = [ pin: "3333",
               amount: ".01"]
      Dwolla.FundingSources.deposit("12345", body, client(token: "token"))
      assert called HTTPoison.post("https://uat.dwolla.com/oauth/rest/fundingsources/12345/deposit?oauth_token=token", 
      JSON.encode!(body),
      [{"Content-Type","application/json"}])
    end
  end

  test "should withdraw" do
    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> empty_response() end] do
      body = [ pin: "3333",
               amount: ".01"]
      Dwolla.FundingSources.withdraw("12345", body, client(token: "token"))
      assert called HTTPoison.post("https://uat.dwolla.com/oauth/rest/fundingsources/12345/withdraw?oauth_token=token",
      JSON.encode!(body),
      [{"Content-Type","application/json"}])
    end
  end

end
