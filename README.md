[![Build Status](https://travis-ci.org/lochnesh/dwolla_elixir.png?branch=master)](https://travis-ci.org/lochnesh/dwolla_elixir)

# DwollaElixir
An Elixir wrapper for Dwolla's API
[Dwolla API docs](https://developers.dwolla.com/dev/)

## Usage

Add DwollaElixir as a dependency to your `mix.exs` file

```` elixir
defp deps do
  [{:dwolla_elixir, github: "lochnesh/dwolla_elixir"}]
end
````

You should also update your applications list to include dwolla:

````elixir
def application do
  [applications: [:dwolla_elixir]]
end
````

## Obtaining a client
The Dwolla end points require the application key and secret or an oauth token. This API wrapper uses an Elixir record called Client which holds all three.  The wrapped end points require a Client record.  To obtain a client record, 

```` elixir
#set application variables in mix.exs 
#or set environment variable key, secret, token
#then call 
client = Dwolla.Client.new

#to define inline
client = Dwolla.Client.client(key: "KEY", secret: "SECRET", token: "TOKEN")
````

## Examples
To start in interactive console
```` elixir
iex -S mix
```` 

- Obtain a client record
```` elixir
require Dwolla.Client
client = Dwolla.Client.client(key: "KEY", secret: "SECRET", token: "TOKEN")
````

- Get user by Id
```` elixir
Dwolla.Users.get("reflector@dwolla.com",client)
````

## Integration tests
Integration tests are contained in integration_test folder. Integration tests execute against the [Dwolla UAT environment](https://uat.dwolla.com) To run, define the following environment variables (you will need to obtain an application key, secret, and an oauth_token.
[Get oauth token](https://developers.dwolla.com/dev/token)

````sh
export MIX_ENV=all
export KEY={YOUR_KEY}
export SECRET=(YOUR_SECRET}
export TOKEN={SOME_TEST_USER_TOKEN}
export MERCHANT_TOKEN={ANOTHER_TEST_USER_TOKEN}
export PIN={TEST_USER_PIN}
```` 

## Support

- Dwolla API | api@dwolla.com | [@DwollaAPI](https://twitter.com/DwollaAPI)
- Skyler Nesheim | skyler@dwolla.com | [@skylernesheim](https://twitter.com/skylernesheim)

## License

Copyright © 2014 Dwolla

Released under the MIT License:
<http://www.opensource.org/licenses/mit-license.php>
