# DwollaElixir

To start
```` elixir
iex -S mix
```` 

Examples

-Get user by Id

```` elixir
require DwollaElixir.Client
client = DwollaElixir.Client.client(key: "KEY", secret: "SECRET")
DwollaElixir.Users.get("reflector@dwolla.com",client)
````
