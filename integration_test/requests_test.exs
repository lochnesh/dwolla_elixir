defmodule RequestsIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
  import Dwolla.IntegrationTest

  test "should request money" do
    assert true == request()
    |> Dict.fetch!("Success")
  end

  test "should fulfill request" do
    id = request() |> Dict.fetch!("Response")

    response = Dwolla.Requests.fulfill(
      id,
      [pin: get_pin(),
       amount: ".01"],
      Dwolla.Client.client(token: get_merchant_token())) 

    details = Dict.fetch!(response, "Response")

    assert true == response |> Dict.fetch!("Success")
    assert 0.01 == Dict.fetch!(details, "Amount")
    assert "812-201-0130" == details |> Dict.fetch!("Source") |> Dict.fetch!("Id")
    assert "812-443-3023" == details |> Dict.fetch!("Destination") |> Dict.fetch!("Id")
  end

  test "should list pending requests" do
    request()
    request()
    request()

    response = Dwolla.Requests.list(
      Dwolla.Client.client(token: get_merchant_token()),
      %{"start_date" => "2014-04-01",
        "limit" => "3"})

    details = Dict.fetch!(response, "Response")

    assert true == response |> Dict.fetch!("Success")
    assert 3 == details |> Enum.count 
    assert true = details |> Enum.all?(fn(x) -> Dict.fetch!(x, "Status") == "Pending" end) 

  end
  
  test "should get requests by id" do 
    id = request() |> Dict.fetch!("Response")

    response = Dwolla.Requests.get_by_id(id, Dwolla.Client.new)

    assert true == response |> Dict.fetch!("Success")
    assert id  == response |> Dict.fetch!("Response") |> Dict.fetch!("Id")
  end

  test "should cancel request" do 
    assert true == request() 
      |> Dict.fetch!("Response")
      |> Dwolla.Requests.cancel(Dwolla.Client.new)
      |> Dict.fetch!("Success")
  end

  defp request, do: Dwolla.Requests.request(
      [sourceId: "812-201-0130",
       amount: ".01"], Dwolla.Client.new)

end 

