![Ruby](https://github.com/kwent/omniauth-monday/workflows/Ruby/badge.svg?branch=master)

# OmniAuth Monday

This is the official OmniAuth strategy for authenticating to Monday. To
use it, you'll need to sign up for an OAuth2 Client ID and Secret at Monday.com.

## Installation

```ruby
gem 'omniauth-monday'
```

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :monday, ENV['MONDAY_CLIENT_ID'], ENV['MONDAY_CLIENT_SECRET'], { scope: 'me boards:read' }
end
```

## Basic Usage Rails

In `config/initializers/monday.rb`

```ruby
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :monday, ENV['MONDAY_CLIENT_ID'], ENV['MONDAY_CLIENT_SECRET'], { scope: 'me boards:read' }
  end
```

## Semver

This project adheres to Semantic Versioning 2.0.0. Any violations of this scheme are considered to be bugs.
All changes will be tracked [here](https://github.com/rob-race/omniauth-monday/releases).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rob-race/omniauth-monday.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).