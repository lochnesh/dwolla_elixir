defmodule FundingSourcesIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
  import Dwolla.IntegrationTest

  test "should get funding sources list" do
    response = Dwolla.FundingSources.list(Dwolla.Client.new)

    success = Dict.fetch!(response, "Success")
    details = Dict.fetch!(response, "Response")

    assert true == success
    assert 2 == Enum.count details
    assert "Balance" == Dict.fetch!(Enum.fetch!(details, 0), "Id")

  end

  test "should get details by id" do
    response = Dwolla.FundingSources.list(Dwolla.Client.new)
    id = Dict.fetch!(Enum.fetch!(Dict.fetch!(response, "Response"), 1), "Id")
    funding_source = Dwolla.FundingSources.get_by_id(id, Dwolla.Client.new)

    assert true = Dict.fetch!(funding_source, "Success")
  end

  test "should deposit" do 
    response = Dwolla.FundingSources.list(Dwolla.Client.new)
    |> Dict.fetch!("Response")
    |> Enum.fetch!(1)
    |> Dict.fetch!("Id")
    |> Dwolla.FundingSources.deposit( 
    [ pin: get_pin(),
      amount: "1.00"],
      Dwolla.Client.new)
    
    assert true = Dict.fetch!(response, "Success")
  end

end
  

