defmodule TransactionsIntegrationTest do
  use ExUnit.Case
  import Dwolla.IntegrationTest
  import Dwolla.Client

  test "should send money" do
    response = Dwolla.Transactions.send(
      [ destinationId: "812-201-0130",
        pin: get_pin(),
        amount: ".01"], client(token: get_token()))
    
    success = HashDict.fetch!(response, "Success")

    assert true == success
  end

  test "should get by id" do
    client = client(token: get_token())
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
      client(token: get_token()),
      %{"startDate" => "2014-04-01"})
    
    success = HashDict.fetch!(response, "Success")
    details = HashDict.fetch!(response, "Response")

    assert true == success
    assert 1 <= HashDict.fetch!(details, "TransactionsCount")
    assert 1 <= HashDict.fetch!(details, "TransactionsTotal")
  end

end
  

