module Kasey
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    def has_access?(user, kase)
      return true unless Kasey.configuration.auth_required

      call_or_send(Kasey.configuration.authorize_function, user, kase)
    end

    def authenticate!
      return unless Kasey.configuration.auth_required

      call_or_send(Kasey.configuration.authenticate_function)
    end

    def authenticated_user
      return unless Kasey.configuration.auth_required

      call_or_send(Kasey.configuration.authenticated_user_function)
    end

    private

    def call_or_send(val, *args)
      case val
      when Proc
        val.call(*args)
      when Symbol
        send(val, *args)
      else
        raise 'configuration value is not allowed'
      end
    end
  end
end
