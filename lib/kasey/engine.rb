require 'action_mailbox/engine'
require 'active_storage/engine'
require 'webpacker'

module Kasey
  class Engine < ::Rails::Engine
    engine_name 'kasey'
    isolate_namespace Kasey

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end

    initializer 'webpacker.proxy' do |app|
      next unless (Kasey.webpacker.config.dev_server.present? rescue nil)

      app.middleware.insert_before(
        0,
        Rails::VERSION::MAJOR >= 5 ?
          Webpacker::DevServerProxy :
          'Webpacker::DevServerProxy',
        ssl_verify_none: true,
        webpacker: Kasey.webpacker
      )
    end
  end
end
