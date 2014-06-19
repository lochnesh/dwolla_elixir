defmodule UsersIntegrationTest do
  use ExUnit.Case

  import DwollaElixir.Client

  test "should get basic user info" do
    response = DwollaElixir.Users.get("skyler@dwolla.com",DwollaElixir.IntegrationTest.client())
    
    user_response = response.body |> JSON.decode

    user = HashDict.fetch!(elem(user_response,1), "Response")
    success = HashDict.fetch!(elem(user_response,1), "Success")

    assert true == success
    assert "Skyler Nesheim" == HashDict.fetch!(user, "Name")
    assert "812-443-3023" == HashDict.fetch!(user, "Id")

  end

end

