defmodule UsersTest do 
  use ExUnit.Case
  import Mock

  test_with_mock "should get users by id", HTTPoison,
  [get: fn(_url) -> "stuff" end] do
    assert Users.get("reflector@dwolla.com") == "stuff" 
  end

end
