defmodule RequestsIntegrationTest do
  use ExUnit.Case
  import Dwolla.IntegrationTest

  test "should request money" do
    response = Dwolla.Requests.request(
      [sourceId: "812-201-0130",
       amount: ".01"], Dwolla.Client.new)
    
    success = HashDict.fetch!(response, "Success")
    id = HashDict.fetch!(response, "Response")

    assert true == success
    assert 0 < id

  end

end 

