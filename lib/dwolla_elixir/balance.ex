defmodule Dwolla.Balance do
  import Dwolla.Client

  @moduledoc """
  A wrapper for Balance end point in the DwollaAPI
  """

  @doc "https://developers.dwolla.com/dev/docs/balance/balance"
  def get(client), do: get_with_token("balance/", client(client, :token))

end
