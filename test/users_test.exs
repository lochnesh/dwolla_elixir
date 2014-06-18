defmodule UsersTest do 
  use ExUnit.Case

  def basic_user() do
    JSEX.encode! [
    Success: true, 
    Message: "Success", 
    Response: JSEX.encode! [
      Id: "812-111-1111",
      Latitude: 41.584546,
      Longitude: -93.634167,
      Name: "Test User"
      ]
    ]  
  end

end
