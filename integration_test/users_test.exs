defmodule UsersIntegrationTest do
  use ExUnit.Case
  import DwollaElixir.IntegrationTest

  test "should get basic user info" do
    user_response = DwollaElixir.Users.get("skyler@dwolla.com", client())

    success = HashDict.fetch!(user_response, "Success")
    user = HashDict.fetch!(user_response, "Response")

    assert true == success
    assert "Skyler Nesheim" == HashDict.fetch!(user, "Name")
    assert "812-443-3023" == HashDict.fetch!(user, "Id")
  end
  
  test "should get account info with oauth token" do
    user_response = DwollaElixir.Users.account(client_with_token())
    
    success = HashDict.fetch!(user_response, "Success")
    user = HashDict.fetch!(user_response, "Response")

    assert true == success
    assert "Skyler Nesheim" == HashDict.fetch!(user, "Name")
    assert "812-443-3023" == HashDict.fetch!(user, "Id")
    assert "Des Moines" == HashDict.fetch!(user, "City")
    assert "Personal" == HashDict.fetch!(user, "Type")
  end

  test "should get avatar given dwolla id" do
    response = DwollaElixir.Users.avatar("812.443.3023").body 
      
    assert nil != response
  end

  test "should get nearby" do 
    response = DwollaElixir.Users.nearby(0,0,client())

    success = HashDict.fetch!(response, "Success")

    assert true == success
  end

end

