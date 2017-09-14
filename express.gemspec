$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "express/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "express"
  s.version     = Express::VERSION
  s.authors     = ["johndavid400"]
  s.email       = ["johndavid400@gmail.com"]
  s.homepage    = "https://github.com/johndavid400"
  s.summary     = "A basic CMS Rails engine"
  s.description = "Express is cms."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'rspec-rails'
  s.add_dependency 'friendly_id', '~> 5.1.0'
  s.add_dependency 'dragonfly', '~> 1.1.3'
  s.add_dependency "font-awesome-rails"
  s.add_dependency 'capybara'
  s.add_dependency 'factory_girl_rails'
  s.add_dependency 'simplecov'
  s.add_dependency 'shoulda-matchers'

  s.add_development_dependency "pg"
  s.add_development_dependency "pg_search"

end
