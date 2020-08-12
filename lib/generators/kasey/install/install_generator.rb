module Kasey
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def copy_initializer
      template "initializer.rb", "config/initializers/kasey.rb"
    end
  end
end
