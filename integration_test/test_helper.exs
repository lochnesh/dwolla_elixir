ExUnit.start

:application.set_env(:dwolla_elixir, :url, "https://uat.dwolla.com/oauth/rest/")

defmodule Dwolla.IntegrationTest do
  import Dwolla.Client
  
  def client do  
    client(
      key: System.get_env("KEY"),
      secret: System.get_env("SECRET") 
      )
  end

  def client_with_token do  
    client(
      token: System.get_env("TOKEN")
      )
  end

  def get_token do
    System.get_env("TOKEN")
  end

  def get_pin do
    System.get_env("PIN")
  end

end

  

