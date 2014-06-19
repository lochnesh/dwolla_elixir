defmodule TransactionsIntegrationTest do
  use ExUnit.Case
  import DwollaElixir.IntegrationTest
  import DwollaElixir.Client

  test "should send money" do
    response = DwollaElixir.Transactions.send(
      [ destinationId: "812-201-0130",
        pin: get_pin(),
        amount: ".01"], client(token: get_token())).body |> JSON.decode!

    
    success = HashDict.fetch!(response, "Success")

    assert true == success
  end
end
  

