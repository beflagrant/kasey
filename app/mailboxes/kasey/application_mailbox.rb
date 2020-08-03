class Kasey::ApplicationMailbox < ActionMailbox::Base
  routing (/kasey/i) => "Kasey::KaseInbox" #JAAAANKY
end
