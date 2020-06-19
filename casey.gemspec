$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'casey/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'casey'
  spec.version     = Casey::VERSION
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

  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.1'
  spec.add_dependency 'wicked', '~> 1.3.4'

  spec.add_development_dependency 'sqlite3', '~> 1.4.2'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
end
