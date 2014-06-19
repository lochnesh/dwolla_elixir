defmodule TransactionsTest do 
  use ExUnit.Case
 
  import Mock
  import DwollaElixir.Client
  
  test "should send money" do 
    with_mock HTTPoison, [post: fn(_url, _body, _headers) -> :ok end] do
      body = [ destinationId: "812-111-1111",
               pin: "3333",
               amount: "5.50"] 
      DwollaElixir.Transactions.send(body,client(token: "token"))
      assert called HTTPoison.post(
        "https://uat.dwolla.com/oauth/rest/transactions/send?oauth_token=token",
        JSON.encode!(body),
        [{"Content-Type","application/json"}]) 
    end
  end

end
 
