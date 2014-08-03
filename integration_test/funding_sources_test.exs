defmodule FundingSourcesIntegrationTest do
  use ExUnit.Case
  require Dwolla.Client

  test "should get funding sources list" do
    response = Dwolla.FundingSources.list(Dwolla.Client.new)

    success = HashDict.fetch!(response, "Success")
    details = HashDict.fetch!(response, "Response")

    assert true == success
    assert 2 == Enum.count details
    assert "Balance" == HashDict.fetch!(Enum.fetch!(details, 0), "Id")

  end

  test "should get details by id" do
    response = Dwolla.FundingSources.list(Dwolla.Client.new)
    id = HashDict.fetch!(Enum.fetch!(HashDict.fetch!(response, "Response"), 1), "Id")
    funding_source = Dwolla.FundingSources.get_by_id(id, Dwolla.Client.new)

    assert true = HashDict.fetch!(funding_source, "Success")
  end

end
  

