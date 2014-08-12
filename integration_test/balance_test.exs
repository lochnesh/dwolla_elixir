defmodule BalanceIntegrationTest do
  use ExUnit.Case

  test "should get balance" do
    response = Dwolla.Balance.get(Dwolla.Client.new)
    
    success = Dict.fetch!(response, "Success")
    balance = Dict.fetch!(response, "Response")

    assert true == success
    assert balance > 0
  end

end

