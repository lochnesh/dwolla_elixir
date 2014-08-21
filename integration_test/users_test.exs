defmodule UsersIntegrationTest do
  use ExUnit.Case

  test "should get basic user info" do
    user_response = Dwolla.Users.get("skyler@dwolla.com", Dwolla.Client.new)

    user = Dict.fetch!(user_response, "Response")

    assert true == user_response |> Dict.fetch!("Success")
    assert "Skyler Nesheim" == user |> Dict.fetch!("Name")
    assert "812-443-3023" == user |> Dict.fetch!("Id")
  end
  
  test "should get account info with oauth token" do
    user_response = Dwolla.Users.account(Dwolla.Client.new)
    
    user = Dict.fetch!(user_response, "Response")

    assert true == user_response |> Dict.fetch!("Success")
    assert "Skyler Nesheim" == Dict.fetch!(user, "Name")
    assert "812-443-3023" == Dict.fetch!(user, "Id")
    assert "Des Moines" == Dict.fetch!(user, "City")
    assert "Personal" == Dict.fetch!(user, "Type")
  end

  test "should get avatar given dwolla id" do
    response = Dwolla.Users.avatar("812.443.3023").body 
    
    assert nil != response
  end

  test "should get nearby" do 
    assert true  = Dwolla.Users.nearby(0,0,Dwolla.Client.new)
      |> Dict.fetch!("Success")
  end

end

