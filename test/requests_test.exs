defmodule RequestsTest do 
  use ExUnit.Case
 
  import Mock
  import Dwolla.Client
  import EmptyHttp
  
  test "should request money" do 
    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> empty_response() end] do
      
      body = [sourceId: "812-201-0130", amount: 0.01]
      Dwolla.Requests.request(body, client(token: "token"))
      assert called HTTPoison.post( 
        "https://uat.dwolla.com/oauth/rest/requests/?oauth_token=token",
        JSON.encode!(body),
        [{"Content-Type","application/json"}])
    end
  end

  test "should fullfill request" do
    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> empty_response() end] do
      id = 123 
      body = [pin: "2222", amount: 0.01]
      Dwolla.Requests.fulfill(id, body, client(token: "token"))
      assert called HTTPoison.post(
        "https://uat.dwolla.com/oauth/rest/requests/#{id}/fulfill?oauth_token=token",
        JSON.encode!(body),
        [{"Content-Type","application/json"}])
    end
  end

end
 
