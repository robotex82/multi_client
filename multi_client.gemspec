$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "multi_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "multi_client"
  s.version     = MultiClient::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["robotex@robotex.de"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MultiClient."
  s.description = "TODO: Description of MultiClient."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
end
