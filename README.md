# Kasey - A Simple Case (Kase) Management Engine

Many apps are case management apps. Often, the choice is 'build a simple case
management tool' to bloat your own application, or connect with an existing
SaaS case management tool via some API.

In the first situation, every line of code is a liability, and the case
management portion may not even be cohesive with the application you're
building. In the second case, money money money.

Kasey (a kase management plugin for Rails) provides a simple case management
workflow engine for inclusion in your new or existing Rails application.

## Installation

This gem uses (and includes) ActiveStorage, ActionMailbox, and ActionText. You
may or may not have set these up in your application. If not, you can find the
instructions as follows:

- [Active
  Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html)
- [Action Text](https://edgeguides.rubyonrails.org/action_text_overview.html)
- [Action Mailbox](https://guides.rubyonrails.org/action_mailbox_basics.html)

Once these are all installed, you'll want to add the gem to your Gemfile. If
you're just using the gem, add:

`$> gem 'kasey' # this doesn't work yet`

or

`$> gem 'kasey', git: 'https://github.com/beflagrant/kasey'`

If you're _working on_ Kasey, add `kasey` as a git submodule:

```bash
$> git submodule add git@github.com:beflagrant/kasey vendor/kasey`
$> git submodule update --init
```

You'll likely also want to commit the .gitmodules file, unless the previous
exercise made you happy.

You'll also need to add kasey to with a path:

`gem 'kasey', path: 'vendor/kasey'`

Once the gem is in your Gemfile:

```bash
$ bundle
$ rails kasey:setup
$ rails db:migrate
```

### Add Kasey to your Routes

Let your application know where to mount Kasey's routes
by adding the following to your `config/routes.rb` file:

```ruby
Rails.application.routes.draw do
  # other routes before or after
  mount Kasey::Engine, at: '/kasey'
end
```

### Konfigure Kasey

After running `rails kasey:install`, you will have an initializer in
`config/initializers/kasey.rb`. Update this file with your app's configuration.

TBD!

## Intakes

Kasey keeps track of communication with someone submitting an _intake_. An
intake is a collection of data submitted to your application. This could be
an office sign-in sheet, a real estate query, or a simple contact form. Kasey
doesn't care what it is, as long as it has at least one field called `email`.

In order for Kasey to track an intake object, you should add the `kase_managed`
directive to the object, for example:

```ruby
class Contact < ApplicationRecord
  kase_managed

  validates_presence_of :name, :email, :message, :deadline
end
```

When a new intake is created, a Kasey::Kase will be created to manage it.

### Customizing Intakes

When you view a Kase, the Intake's data will also be displayed by default. This
will simply be the attribute data on the model. You can, however, display the
data however you want by creating a Kasey partial inside of your application's
`views` directory. In `views/`, create a `kasey` directory. Then for each kind of intake in your system, create a partial to display it however you like. For example, to customize the in-Kase display of the Contact above, we would create the file:

`app/views/kasey/contacts/_contact.html.erb`

We could the populate it however we liked:

```
<div class="content">
  <p>Name: <%= contact.name %></p>
  <p>Email: <%= contact.email %></p>
  <p>Message: <%= contact.message %></p>
  <p>Deadline <%= contact.deadline %></p>
</div>

```

This partial would be rendered at the head of the

## Development

## Testing

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
