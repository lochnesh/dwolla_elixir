defmodule Dwolla.Requests do
  import Dwolla.Client

  @moduledoc """
  A wrapper for Requests end points in the Dwolla API
  """

  @doc "https://developers.dwolla.com/dev/docs/requests/request"
  def request(body, client), do: post("requests/", client(client, :token), body)

  @doc "https://developers.dwolla.com/dev/docs/requests/fulfill"
  def fulfill(id, body, client), do: post("requests/#{id}/fulfill", client(client, :token), body)

  @doc "https://developers.dwolla.com/dev/docs/requests/pending"
  def list(client, params \\ %{}), do: get_with_token("requests/", client(client, :token), params)

  @doc "https://developers.dwolla.com/dev/docs/requests/cancel"
  def cancel(request_id, client), do: post("requests/#{request_id}/cancel", client(client, :token), [])

  @doc "https://developers.dwolla.com/dev/docs/requests/byid"
  def get_by_id(request_id, client), do: get_with_token("requests/#{request_id}", client(client, :token))
end
 
