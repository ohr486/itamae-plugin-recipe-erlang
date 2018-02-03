# Itamae::Plugin::Recipe::Erlang

[![Gem Version](https://badge.fury.io/rb/itamae-plugin-recipe-erlang.svg)](https://badge.fury.io/rb/itamae-plugin-recipe-erlang)
[![wercker status](https://app.wercker.com/status/d64235a018605ddf4ebee04532597235/m/master "wercker status")](https://app.wercker.com/project/byKey/d64235a018605ddf4ebee04532597235)

Itamae plugin to install erlang with kerl

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-erlang'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-erlang

## Usage

### Recipe

```ruby
# your recipe
include_recipe "erlang::install"
```

### Node

Use this with `itamae -y node.yml`

```yaml
# node.yml
erlang:
  # target version
  version: 20.2
  # build options, see: https://github.com/kerl/kerl#build-configuration
  configure_options: ""
  enable_apps: ""
  disable_apps: ""
```

## Testing

requirements [Vagrant](https://www.vagrantup.com/)

```sh
bundle exec rake itamae:default
bundle exec rake spec:default
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
