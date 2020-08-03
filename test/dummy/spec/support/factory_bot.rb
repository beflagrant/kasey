require 'factory_bot'

#puts "DUMMY-LOCAL FACTORY BOT HELPER"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
