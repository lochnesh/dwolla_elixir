# DwollaElixir

To start
iex -S mix 

Examples

-Get user by Id

require DwollaElixir.Client
client = DwollaElixir.Client.client(key: "KEY", secret: "SECRET")
DwollaElixir.Users.get("reflector@dwolla.com",client)

