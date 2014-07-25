ExUnit.start

:application.set_env(:dwolla_elixir, :url, "https://uat.dwolla.com/oauth/rest/")

defmodule Dwolla.IntegrationTest do
  def get_pin do
    System.get_env("PIN")
  end

  def get_merchant_token do
    System.get_env("MERCHANT_TOKEN")
  end

end

  

