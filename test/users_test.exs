defmodule UsersTest do 
  use ExUnit.Case

  test "should get users by id" do
    assert Users.get("reflector@dwolla.com") != nil 
  end

end
