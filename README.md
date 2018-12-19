# Fitbit

fitbit-api-client provides access to Fitbit API. fitbit-api-client supports OAuth 2.0.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fitbit-api-client', require: 'fitbit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fitbit-api-client

## Usage

```ruby
client = Fitbit::Client.new(
  client_id: Settings.fitbit.client_id,
  client_secret: Settings.fitbit.client_secret,
  token: current_user.token,
  refresh_token: current_user.refresh_token,
  expires_at: current_user.expires_at)

p client.activity
```

If token is expired, client uses refresh_token and update tokens.

```ruby
# This client token is expired and refreshed automatically.
p client.activity

# Updated tokens
client.access_token.token
client.access_token.refresh_token
client.access_token.expires_at
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaorumori/fitbit-api-ruby-client.
