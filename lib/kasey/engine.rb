require 'action_mailbox/engine'
require 'active_storage/engine'

module Kasey
  class Engine < ::Rails::Engine
    engine_name 'kasey'
    isolate_namespace Kasey

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          puts "!!!! appending: #{expanded_path} to migrations path."
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
