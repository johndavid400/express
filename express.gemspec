$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "express/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "express"
  s.version     = Express::VERSION
  s.authors     = ["johndavid400"]
  s.email       = ["johndavid400@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Express."
  s.description = "TODO: Description of Express."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_development_dependency "sqlite3"
end
