$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'kasey/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'kasey'
  spec.version     = Kasey::VERSION
  spec.authors     = ['Ben Vandgrift']
  spec.email       = ['ben@vandgrift.com']
  spec.summary     = 'a case management engine and workflow generator'
  spec.description = 'a case management engine and workflow generator'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this section
  # to allow pushing to any host.
  spec.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]
  spec.test_files = Dir["spec/**/*"]

  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.1'
  spec.add_dependency 'rake'
  spec.add_dependency 'aasm'
  spec.add_dependency 'image_processing', '~> 1.2'
  # spec.add_dependency 'wicked', '~> 1.3.4'
  spec.add_dependency 'sass-rails', '>= 6'
  spec.add_dependency 'webpacker', '~> 5.2'

  spec.add_development_dependency 'sqlite3', '~> 1.4.2'
  spec.add_development_dependency 'rspec-rails', '~> 4.0.1'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'factory_bot_rails'
end


#gem "aws-sdk-s3", require: false
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
