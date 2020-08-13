require 'pry'
module Kasey
  class ApplicationController < ::ApplicationController # ActionController::Base
    protect_from_forgery with: :exception
    #include Kasey::Helpers

    def has_access?(user, kase)
      return true unless Kasey.configuration.auth_required

      return call_or_send(Kasey.configuration.authorize_function, user, kase)
      #raise NotImplementedError, 'replace this with code to evaluate access'
    end

    def authenticate!
      return unless Kasey.configuration.auth_required

      call_or_send(Kasey.configuration.authenticate_function)

      #authenticate_user!
    end

    def authenticated_user
      return unless Kasey.configuration.auth_required

      call_or_send(Kasey.configuration.authenticated_user_function)
    end

  private

    def call_or_send(val, *args)
      case val
      when Proc
        return val.call(*args)
      when Symbol
        return send(val, *args)
      else
        raise 'configuration value is not allowed'
      end
    end
  end
end
