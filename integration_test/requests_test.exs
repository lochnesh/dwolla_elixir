defmodule RequestsIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
  import Dwolla.IntegrationTest

  test "should request money" do
    response = request()
    
    success = Dict.fetch!(response, "Success")
    id = Dict.fetch!(response, "Response")

    assert true == success
    assert 0 < id
  end

  test "should fulfill request" do
    id = Dict.fetch!(request(), "Response")

    response = Dwolla.Requests.fulfill(
      id,
      [pin: get_pin(),
       amount: ".01"],
      Dwolla.Client.client(token: get_merchant_token())) 

    success = Dict.fetch!(response, "Success")
    details = Dict.fetch!(response, "Response")
    source = Dict.fetch!(details, "Source")
    dest = Dict.fetch!(details, "Destination")

    assert true == success
    assert 0.01 == Dict.fetch!(details, "Amount")
    assert "812-201-0130" == Dict.fetch!(source,"Id")
    assert "812-443-3023" == Dict.fetch!(dest,"Id")
  end

  test "should list pending requests" do
    request()
    request()
    request()

    response = Dwolla.Requests.list(
      Dwolla.Client.client(token: get_merchant_token()),
      %{"start_date" => "2014-04-01",
        "limit" => "3"})

    success = Dict.fetch!(response, "Success")
    details = Dict.fetch!(response, "Response")

    assert true == success
    assert 3 == Enum.count details
    assert true = Enum.all? details, fn(x) -> Dict.fetch!(x, "Status") == "Pending" end 

  end
  
  test "should get requests by id" do 
    id = Dict.fetch!(request(), "Response")

    response = Dwolla.Requests.get_by_id(id, Dwolla.Client.new)

    success = Dict.fetch!(response, "Success")
    returned_id = Dict.fetch!(Dict.fetch!(response, "Response"), "Id")

    assert true == success
    assert returned_id == id
  end

  test "should cancel request" do 
    id = Dict.fetch!(request(), "Response")

    response = Dwolla.Requests.cancel(id, Dwolla.Client.new)

    success = Dict.fetch!(response, "Success")

    assert true == success
  end

  defp request, do: Dwolla.Requests.request(
      [sourceId: "812-201-0130",
       amount: ".01"], Dwolla.Client.new)


end 

