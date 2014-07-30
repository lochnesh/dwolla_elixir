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

end
  

