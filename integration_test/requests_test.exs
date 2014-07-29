defmodule RequestsIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
  import Dwolla.IntegrationTest

  test "should request money" do
    response = request()
    
    success = HashDict.fetch!(response, "Success")
    id = HashDict.fetch!(response, "Response")

    assert true == success
    assert 0 < id
  end

  test "should fulfill request" do
    id = HashDict.fetch!(request(), "Response")

    response = Dwolla.Requests.fulfill(
      id,
      [pin: get_pin(),
       amount: ".01"],
      Dwolla.Client.client(token: get_merchant_token())) 

    success = HashDict.fetch!(response, "Success")
    details = HashDict.fetch!(response, "Response")
    source = HashDict.fetch!(details, "Source")
    dest = HashDict.fetch!(details, "Destination")

    assert true == success
    assert 0.01 == HashDict.fetch!(details, "Amount")
    assert "812-201-0130" == HashDict.fetch!(source,"Id")
    assert "812-443-3023" == HashDict.fetch!(dest,"Id")
  end

  test "should list pending requests" do
    request()
    request()
    request()

    response = Dwolla.Requests.list(
      Dwolla.Client.client(token: get_merchant_token()),
      %{"start_date" => "2014-04-01",
        "limit" => "3"})

    success = HashDict.fetch!(response, "Success")
    details = HashDict.fetch!(response, "Response")

    assert true == success
    assert 3 == Enum.count details
    assert true = Enum.all? details, fn(x) -> HashDict.fetch!(x, "Status") == "Pending" end 

  end
  
  test "should get requests by id" do 
    id = HashDict.fetch!(request(), "Response")

    response = Dwolla.Requests.get_by_id(id, Dwolla.Client.new)

    success = HashDict.fetch!(response, "Success")
    returned_id = HashDict.fetch!(HashDict.fetch!(response, "Response"), "Id")

    assert true == success
    assert returned_id == id
  end

  test "should cancel request" do 
    id = HashDict.fetch!(request(), "Response")

    response = Dwolla.Requests.cancel(id, Dwolla.Client.new)

    success = HashDict.fetch!(response, "Success")

    assert true == success
  end

  defp request, do: Dwolla.Requests.request(
      [sourceId: "812-201-0130",
       amount: ".01"], Dwolla.Client.new)


end 

