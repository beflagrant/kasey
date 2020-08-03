require_relative 'boot'

require 'rails/all'
require 'active_storage/engine'
require 'action_mailbox/engine'

Bundler.require(*Rails.groups)
require "kasey"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

