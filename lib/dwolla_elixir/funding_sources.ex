defmodule Dwolla.FundingSources do
  import Dwolla.Client

  @moduledoc """
  A wrapper for FundingSources end points in the Dwolla API
  """

  @doc "https://developers.dwolla.com/dev/docs/funding/listing"
  def list(client, params \\ %{}), do: get_with_token("fundingsources/", client(client,:token), params)

end
 
