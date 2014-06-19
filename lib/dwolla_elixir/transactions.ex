defmodule DwollaElixir.Transactions do
  import DwollaElixir.Client

  def send(body,client), do: post("transactions/send",client(client,:token), body)

end
 
