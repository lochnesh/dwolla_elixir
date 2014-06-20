defmodule Dwolla.Requests do
  import Dwolla.Client

  @moduledoc """
  A wrapper for Requests end points in the Dwolla API
  """

  @doc "https://developers.dwolla.com/dev/docs/requests/request"
  def request(body,client), do: post("requests/",client(client,:token), body)

  @doc "https://developers.dwolla.com/dev/docs/requests/fulfill"
  def fulfill(id,body,client), do: post("requests/#{id}/fulfill",client(client,:token), body)

end
 
