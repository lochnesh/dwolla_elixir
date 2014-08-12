defmodule FundingSourcesIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client
  import Dwolla.IntegrationTest

  test "should get funding sources list" do
    response = Dwolla.FundingSources.list(Dwolla.Client.new)

    details = Dict.fetch!(response, "Response")

    assert true == Dict.fetch!(response, "Success")
    assert 2 == Enum.count details
    assert "Balance" == Enum.fetch!(details, 0) |> Dict.fetch!("Id")

  end

  test "should get details by id" do
    assert true = Dwolla.FundingSources.list(Dwolla.Client.new)
    |> Dict.fetch!("Response")
    |> Enum.fetch!(1)
    |> Dict.fetch!("Id")
    |> Dwolla.FundingSources.get_by_id(Dwolla.Client.new)
    |> Dict.fetch!("Success")

  end

  test "should deposit" do 
    assert true = Dwolla.FundingSources.list(Dwolla.Client.new)
    |> Dict.fetch!("Response")
    |> Enum.fetch!(1)
    |> Dict.fetch!("Id")
    |> Dwolla.FundingSources.deposit([ pin: get_pin(), amount: "1.00"], Dwolla.Client.new)
    |> Dict.fetch!("Success")
    
  end

  test "should withdraw" do
    assert true  = Dwolla.FundingSources.list(Dwolla.Client.new)
    |> Dict.fetch!("Response")
    |> Enum.fetch!(1)
    |> Dict.fetch!("Id")
    |> Dwolla.FundingSources.withdraw([pin: get_pin(), amount: "1.00"], Dwolla.Client.new)
    |> Dict.fetch!("Success")
  end

end
  

