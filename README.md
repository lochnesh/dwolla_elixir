[![Build Status](https://travis-ci.org/lochnesh/dwolla_elixir.png?branch=master)](https://travis-ci.org/lochnesh/dwolla_elixir)

# DwollaElixir

To start
```` elixir
iex -S mix
```` 

Examples

-Get user by Id

```` elixir
require Dwolla.Client
client = Dwolla.Client.client(key: "KEY", secret: "SECRET")
Dwolla.Users.get("reflector@dwolla.com",client)
````
