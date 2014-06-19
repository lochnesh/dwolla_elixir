defmodule TransactionsIntegrationTest do
  use ExUnit.Case
  import DwollaElixir.IntegrationTest
  import DwollaElixir.Client

  test "should send money" do
    response = DwollaElixir.Transactions.send(
      [ destinationId: "812-201-0130",
        pin: get_pin(),
        amount: ".01"], client(token: get_token()))
    
    success = HashDict.fetch!(response, "Success")

    assert true == success
  end

  test "should get by id" do
    client = client(token: get_token())
    id = HashDict.fetch!(DwollaElixir.Transactions.send([
      destinationId: "812-201-0130",
      pin: get_pin(),
      amount: ".01"], client), "Response") 

    response = DwollaElixir.Transactions.get_by_id(id, client)

    success = HashDict.fetch!(response, "Success")
    transaction = HashDict.fetch!(response, "Response")

    assert true == success
    assert 0.01 == HashDict.fetch!(transaction, "Amount")
    assert "812-201-0130" == HashDict.fetch!(transaction, "DestinationId")
    assert "Dwolla" == HashDict.fetch!(transaction, "UserType")
  end

end
  

