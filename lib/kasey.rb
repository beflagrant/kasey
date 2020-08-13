require 'kasey/engine'
require 'kasey/helpers'

## Kasey module
module Kasey
  mattr_accessor :configuration

  class << self
    ## configure the Kasey module
    def configure
      config = Kasey.configuration ||= Configuration.new(auth_required: false)

      yield config
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

