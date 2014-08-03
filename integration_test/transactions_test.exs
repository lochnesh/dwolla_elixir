defmodule TransactionsIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
  import Dwolla.IntegrationTest

  test "should send money" do
    response = Dwolla.Transactions.send(
      [ destinationId: "812-201-0130",
        pin: get_pin(),
        amount: ".01"], Dwolla.Client.new)
    
    success = Dict.fetch!(response, "Success")

    assert true == success
  end

  #test "should refund money" do
  #  Dwolla.Transactions.send(
  #    [ destinationId: "812-201-0130",
  #      pin: get_pin(),
  #      amount: ".01"], Dwolla.Client.new)
    
  #  listing = Dwolla.Transactions.list(
  #    Dwolla.Client.client(token: get_merchant_token()),
  #    %{"types" => "money_received",
  #      "limit" => "1"})
    
  #  response = Dict.fetch!(listing, "Response")

  #  transaction_id = Dict.fetch!(Enum.fetch!(response, 0), "Id")

  #  refund_response = Dwolla.Transactions.refund(
  #    [ pin: get_pin(),
  #      transactionId: transaction_id,
  #      fundsSource: "Balance",
  #      amount: ".01"], Dwolla.Client.client(token: get_merchant_token()))

  #  success = Dict.fetch!(refund_response, "Success")

  #  assert true == success
  #end

  test "should get by id" do
    client = Dwolla.Client.new
    id = Dict.fetch!(Dwolla.Transactions.send([
      destinationId: "812-201-0130",
      pin: get_pin(),
      amount: ".01"], client), "Response") 

    response = Dwolla.Transactions.get_by_id(id, client)

    success = Dict.fetch!(response, "Success")
    transaction = Dict.fetch!(response, "Response")

    assert true == success
    assert 0.01 == Dict.fetch!(transaction, "Amount")
    assert "812-201-0130" == Dict.fetch!(transaction, "DestinationId")
    assert "Dwolla" == Dict.fetch!(transaction, "UserType")
  end

  test "should get stats" do
   
    response = Dwolla.Transactions.stats(
      Dwolla.Client.new,
      %{"startDate" => "2014-04-01"})
    
    success = Dict.fetch!(response, "Success")
    details = Dict.fetch!(response, "Response")

    assert true == success
    assert 1 <= Dict.fetch!(details, "TransactionsCount")
    assert 1 <= Dict.fetch!(details, "TransactionsTotal")
  end

  test "should get transaction list" do
    response = Dwolla.Transactions.list(
      Dwolla.Client.new,
      %{
        "sinceDate" => "2014-04-01",
        "limit" => "33",
        "types" => "money_sent"  
      })

    success = Dict.fetch!(response, "Success")
    details = Dict.fetch!(response, "Response")

    assert true == success
    assert 33 == Enum.count details
    assert true == Enum.all? details, fn(x) -> Dict.fetch!(x, "Type") == "money_sent" end

  end

end
  

