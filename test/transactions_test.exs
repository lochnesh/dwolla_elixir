defmodule TransactionsTest do 
  use ExUnit.Case
 
  import Mock
  import Dwolla.Client
  import EmptyHttp
  
  test "should send money" do 
    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> empty_response() end] do
      body = [ destinationId: "812-111-1111",
               pin: "3333",
               amount: "5.50"] 
      Dwolla.Transactions.send(body,client(token: "token"))
      assert called HTTPoison.post(
        "https://uat.dwolla.com/oauth/rest/transactions/send?oauth_token=token",
        JSON.encode!(body),
        [{"Content-Type","application/json"}]) 
    end
  end

  test "should get transaction details" do
    with_mock HTTPoison, [get: fn(_url) -> empty_response() end] do
      Dwolla.Transactions.get_by_id("1", client(token: "token"))
      assert called HTTPoison.get "https://uat.dwolla.com/oauth/rest/transactions/1?oauth_token=token"
    end
  end

  test "should get transaction stats" do 
    with_mock HTTPoison, [get: fn(_url) -> empty_response() end] do
      Dwolla.Transactions.stats(client(token: "token"))
      assert called HTTPoison.get "https://uat.dwolla.com/oauth/rest/transactions/stats?oauth_token=token"
    end
  end

  test "should get transaction listing" do
    with_mock HTTPoison, [get: fn(_url) -> empty_response() end] do
      Dwolla.Transactions.list(client(token: "token"), %{"sinceDate" => "2014-04-01"})
      assert called HTTPoison.get "https://uat.dwolla.com/oauth/rest/transactions/?oauth_token=token&sinceDate=2014-04-01"
    end
  end 

  test "should issue refund" do 
    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> empty_response() end] do
      body = [pin: "3333",
              transactionId: "123456",
              fundsSource: "Balance",
              amount: "5.50"]
      Dwolla.Transactions.refund(body,client(token: "token"))
      assert called HTTPoison.post(
        "https://uat.dwolla.com/oauth/rest/transactions/refund?oauth_token=token",
        JSON.encode!(body),
        [{"Content-Type","application/json"}])
    end
  end

end
 
