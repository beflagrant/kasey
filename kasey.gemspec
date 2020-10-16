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
    'README.md',
    'postcss.config.js',
    'package.json'
  ]
  spec.test_files = Dir["spec/**/*"]

  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.1'
  spec.add_dependency 'rake'
  spec.add_dependency 'aasm'
  spec.add_dependency 'image_processing', '~> 1.2'
  # spec.add_dependency 'wicked', '~> 1.3.4'
  spec.add_dependency 'sass-rails', '>= 6'
  spec.add_dependency 'webpacker', '~> 5.2'
  spec.add_dependency 'trix'

  spec.add_development_dependency 'sqlite3', '~> 1.4.2'
  spec.add_development_dependency 'pry'
end
