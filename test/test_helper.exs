ExUnit.start

:application.set_env(:dwolla_elixir, :url, "https://uat.dwolla.com/oauth/rest/")

defmodule EmptyHttp do
  def empty_response(), do: %HTTPoison.Response{body: "{}"} 
end


