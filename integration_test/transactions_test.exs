defmodule TransactionsIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
  import Dwolla.IntegrationTest

  test "should send money" do
    response = Dwolla.Transactions.send(
      [ destinationId: "812-201-0130",
        pin: get_pin(),
        amount: ".01"], Dwolla.Client.new)
    
    success = HashDict.fetch!(response, "Success")

    assert true == success
  end

  test "should refund money" do
    Dwolla.Transactions.send(
      [ destinationId: "812-201-0130",
        pin: get_pin(),
        amount: ".01"], Dwolla.Client.new)
    
    listing = Dwolla.Transactions.list(
      Dwolla.Client.client(token: get_merchant_token()),
      %{"types" => "money_received",
        "limit" => "1"})
    
    response = HashDict.fetch!(listing, "Response")

    transaction_id = HashDict.fetch!(Enum.fetch!(response, 0), "Id")

    refund_response = Dwolla.Transactions.refund(
      [ pin: get_pin(),
        transactionId: transaction_id,
        fundsSource: "Balance",
        amount: ".01"], Dwolla.Client.client(token: get_merchant_token()))

    success = HashDict.fetch!(refund_response, "Success")

    assert true == success
  end

  test "should get by id" do
    client = Dwolla.Client.new
    id = HashDict.fetch!(Dwolla.Transactions.send([
      destinationId: "812-201-0130",
      pin: get_pin(),
      amount: ".01"], client), "Response") 

    response = Dwolla.Transactions.get_by_id(id, client)

    success = HashDict.fetch!(response, "Success")
    transaction = HashDict.fetch!(response, "Response")

    assert true == success
    assert 0.01 == HashDict.fetch!(transaction, "Amount")
    assert "812-201-0130" == HashDict.fetch!(transaction, "DestinationId")
    assert "Dwolla" == HashDict.fetch!(transaction, "UserType")
  end

  test "should get stats" do
   
    response = Dwolla.Transactions.stats(
      Dwolla.Client.new,
      %{"startDate" => "2014-04-01"})
    
    success = HashDict.fetch!(response, "Success")
    details = HashDict.fetch!(response, "Response")

    assert true == success
    assert 1 <= HashDict.fetch!(details, "TransactionsCount")
    assert 1 <= HashDict.fetch!(details, "TransactionsTotal")
  end

  test "should get transaction list" do
    response = Dwolla.Transactions.list(
      Dwolla.Client.new,
      %{
        "sinceDate" => "2014-04-01",
        "limit" => "33",
        "types" => "money_sent"  
      })

    success = HashDict.fetch!(response, "Success")
    details = HashDict.fetch!(response, "Response")

    assert true == success
    assert 33 == Enum.count details
    assert true == Enum.all? details, fn(x) -> HashDict.fetch!(x, "Type") == "money_sent" end

  end

end
  

