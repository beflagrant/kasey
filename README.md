# Kasey

Many apps are case management apps. Often, the choice is 'build a simple case
management tool' to bloat your own application, or connect with an existing
SaaS case management tool via some API.

In the first situation, every line of code is a liability, and the case
management portion may not even be cohesive with the application you're
building. In the second case, money money money.

Kasey (a kase management plugin for Rails) provides a simple case management
workflow engine for inclusion in your new or existing Rails application.


## Installation

### Add the Gem

Add this line to your application's Gemfile:

```ruby
gem 'kasey'
```

And then execute:
```bash
$ bundle
$ rails kasey:install
$ rails kasey:install:migrations
$ rails db:migrate
```

### Konfigure Kasey

After running `rails kasey:install`, you will have an initializer in
`config/initializers/kasey.rb`. Update this file with your app's configuration.

TBD!

## Usage
How to use my plugin. On

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
