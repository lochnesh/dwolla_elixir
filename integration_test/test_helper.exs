ExUnit.start

:application.set_env(:dwolla_elixir, :url, "https://uat.dwolla.com/oauth/rest")

defmodule DwollaElixir.IntegrationTest do
  import DwollaElixir.Client
  
  def client do  
    client(
      key: System.get_env("KEY"),
      secret: System.get_env("SECRET") 
      )
  end
end

  

