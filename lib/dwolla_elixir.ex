defmodule DwollaElixir do
  require Record 
  use Application
  use HTTPoison.Base

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    DwollaElixir.Supervisor.start_link
  end

  Record.defrecord :client, [key: nil, secret: nil, token: nil] 

end
