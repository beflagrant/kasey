# kasey initializer
#
# to configure Kasey for use with your application, you need to 
# tell it a few things. `auth_required` must be a boolean value.
# the rest of the configuration parameters can be a :symbol that is
# the name of a function to call, or a -> { lambda }. in particular,
# `authorize_function` will take a lambda with two arguments, user and
# kase.
#
# these configured params will be called from a controller inheriting from
# ::ApplicationController, so any helpers or methods defined there can be
# used.
#
# the following example assumes Devise, and has a custom function for
# authorization:
# 
#     Kasey.configure do |c|
#       c.auth_required = true
#       c.authenticate_function = :authenticate_user! # from Devise
#       c.authorize_function = ->(user, kase) { kase.assignments.pluck(:user_id).include(user.id) }
#       c.authenticated_user_function = :current_user # from Devise
#     end

Kasey.configure do |c|
  c.auth_required = false
  c.authenticate_function = :configure_authenticate_function_in_kasey_initializer
  c.authorize_function = ->(user, kase) { raise 'configure authorize function in kasey initializer' } 
  c.authenticated_user_function = :configure_authenticated_user_function_in_kasey_initializer
end
