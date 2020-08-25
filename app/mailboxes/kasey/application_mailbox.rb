class Kasey::ApplicationMailbox < ActionMailbox::Base
  # should be configurable
  routing (Kasey.configuration.routing_pattern) => "Kasey::KaseInbox"
end
