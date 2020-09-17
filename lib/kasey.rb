require 'kasey/engine'
require 'kasey/kase_managed'
## Kasey module

module Kasey
  ROOT_PATH = Pathname.new(File.join(__dir__, '..'))

  mattr_accessor :configuration

  class << self
    ## configure the Kasey module
    def configure
      config = Kasey.configuration ||= Configuration.new(auth_required: false)

      yield config
      config_check
    end

    ## provide webpacker access at the engine level
    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: Kasey::Engine.root,
        config_path: Kasey::Engine.root.join('config/webpacker.yml')
      )
    end

    private

    def config_check
      config = Kasey.configuration
      raise ConfigurationError.new('Kasey.configuration cannot be nil') if config.nil?
      raise ConfigurationError.new('Kasey.configuration[:auth_required] must be Boolean') if !!config.auth_required != config.auth_required

      [:authenticate_function, :authorize_function, :authenticated_user_function].each do |f|
        raise_unless_callable(f)
      end

      raise_unless_email_domain_valid

      raise_unless_matchable(:routing_pattern)
    end

    def raise_unless_callable(field)
      raise_unless_acceptable([::Symbol, ::Proc], field)
    end

    def raise_unless_email_domain_valid
      email_domain = Kasey.configuration.email_domain
      return if email_domain.to_s == email_domain

      msg = 'Kasey.configuration[:email_domain] must be a valid string'
      raise Kasey::ConfigurationError.new(msg)
    end

    def raise_unless_matchable(field)
      raise_unless_acceptable([::Regexp, ::String], field)
    end

    def raise_unless_acceptable(accepted, field)
      return if accepted.include?(Kasey.configuration[field].class)

      msg = "Kasey.configuration field #{field} type must be in #{accepted.join(', ')}"
      raise Kasey::ConfigurationError.new(msg)
    end
  end

  ## struct for holding configuration
  Configuration = Struct.new(
    :auth_required,
    :authenticate_function,
    :authorize_function,
    :authenticated_user_function,
    :email_domain,
    :routing_pattern,
  )

  class ConfigurationError < ::StandardError
  end
end

