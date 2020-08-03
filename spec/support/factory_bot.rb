require 'factory_bot' or raise 'NO FACTORY BOT FOUND!'

RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
end
