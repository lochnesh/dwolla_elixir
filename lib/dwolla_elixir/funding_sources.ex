defmodule Dwolla.FundingSources do
  import Dwolla.Client

  @moduledoc """
  A wrapper for FundingSources end points in the Dwolla API
  """

  @doc "https://developers.dwolla.com/dev/docs/funding/listing"
  def list(client, params \\ %{}), do: get_with_token("fundingsources/", client(client,:token), params)

  @doc "https://developers.dwolla.com/dev/docs/funding/byid"
  def get_by_id(id, client), do: get_with_token("fundingsources/#{id}", client(client,:token))

  @doc "https://developers.dwolla.com/dev/docs/funding/deposit"
  def deposit(id, body, client), do: post("fundingsources/#{id}/deposit", client(client, :token), body)
end
 
