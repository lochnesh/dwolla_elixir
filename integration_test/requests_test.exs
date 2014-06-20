defmodule RequestsIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
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

  test "should fulfill request" do
    id = HashDict.fetch!(Dwolla.Requests.request(
      [sourceId: "812-201-0130",
       amount: ".01"], Dwolla.Client.new), "Response")

    response = Dwolla.Requests.fulfill(
      id,
      [pin: get_pin(),
       amount: ".01"],
      Dwolla.Client.client(token: get_other_token())) 

    success = HashDict.fetch!(response, "Success")
    details = HashDict.fetch!(response, "Response")
    source = HashDict.fetch!(details, "Source")
    dest = HashDict.fetch!(details, "Destination")

    assert true == success
    assert 0.01 == HashDict.fetch!(details, "Amount")
    assert "812-201-0130" == HashDict.fetch!(source,"Id")
    assert "812-443-3023" == HashDict.fetch!(dest,"Id")

  end


end 
