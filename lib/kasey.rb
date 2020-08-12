require "kasey/engine"

## Kasey module
module Kasey
  mattr_accessor :configuration

  class << self
    ## configure the Kasey module
    def configure
      config = Kasey.configuration ||= Configuration.new

      yield config
    end
  end

  ## struct for holding configuration
  Configuration = Struct.new(
    :current_user_function,
    :can_edit_intake_function
  )
end

