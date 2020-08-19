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
    end

    ## provide webpacker access at the engine level
    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: ROOT_PATH,
        config_path: ROOT_PATH.join('config/webpacker.yml')
      )
    end
  end

  ## struct for holding configuration
  Configuration = Struct.new(
    :auth_required,
    :authenticate_function,
    :authorize_function,
    :authenticated_user_function,
  )
end

