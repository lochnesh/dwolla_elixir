defmodule DwollaElixir.Transactions do
  import DwollaElixir.Client

  def send(body,client), do: post("transactions/send",client(client,:token), body)
  def get_by_id(id,client), do: get_with_token("transactions/#{id}", client(client,:token))
  def stats(client), do: get_with_token("transactions/stats", client(client,:token))

end
 
