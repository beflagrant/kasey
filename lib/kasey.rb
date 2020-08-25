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
        root_path: ROOT_PATH,
        config_path: ROOT_PATH.join('config/webpacker.yml')
      )
    end

    private

    def config_check
      config = Kasey.configuration
      sym_or_proc = [::Symbol, ::Proc]
      raise ConfigurationError if config.nil? ||
        !!config.auth_required != config.auth_required ||
        !sym_or_proc.include?(config.authenticate_function.class) ||
        !sym_or_proc.include?(config.authorize_function.class) ||
        !sym_or_proc.include?(config.authenticated_user_function.class)
    end

  end

  ## struct for holding configuration
  Configuration = Struct.new(
    :auth_required,
    :authenticate_function,
    :authorize_function,
    :authenticated_user_function,
  )

  class ConfigurationError < ::StandardError
  end
end

