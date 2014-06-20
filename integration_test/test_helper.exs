ExUnit.start

:application.set_env(:dwolla_elixir, :url, "https://uat.dwolla.com/oauth/rest/")

defmodule Dwolla.IntegrationTest do
  def get_pin do
    System.get_env("PIN")
  end

end

  

