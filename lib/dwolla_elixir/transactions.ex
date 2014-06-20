defmodule Dwolla.Transactions do
  import Dwolla.Client

  @moduledoc """
  A wrapper for Transactions end points in the Dwolla API
  """

  @doc "https://developers.dwolla.com/dev/docs/transactions/send"
  def send(body,client), do: post("transactions/send",client(client,:token), body)
  
  @doc "https://developers.dwolla.com/dev/docs/transactions/byid"
  def get_by_id(id,client), do: get_with_token("transactions/#{id}", client(client,:token))
  
  @doc "https://developers.dwolla.com/dev/docs/transactions/stats"
  def stats(client, params \\ %{}), do: get_with_token("transactions/stats", client(client,:token), params)

end
 
