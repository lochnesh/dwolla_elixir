defmodule UsersIntegrationTest do
  use ExUnit.Case
  import DwollaElixir.IntegrationTest

  test "should get basic user info" do
    user_response = DwollaElixir.Users.get("skyler@dwolla.com", client()).body |> JSON.decode!
    
    success = HashDict.fetch!(user_response, "Success")
    user = HashDict.fetch!(user_response, "Response")

    assert true == success
    assert "Skyler Nesheim" == HashDict.fetch!(user, "Name")
    assert "812-443-3023" == HashDict.fetch!(user, "Id")
  end
  
  test "should get account info with oauth token" do
    user_response = DwollaElixir.Users.account(client_with_token()).body |> JSON.decode!
    
    success = HashDict.fetch!(user_response, "Success")
    user = HashDict.fetch!(user_response, "Response")

    assert true == success
    assert "Skyler Nesheim" == HashDict.fetch!(user, "Name")
    assert "812-443-3023" == HashDict.fetch!(user, "Id")
    assert "Des Moines" == HashDict.fetch!(user, "City")
    assert "Personal" == HashDict.fetch!(user, "Type")
  end
    

end

