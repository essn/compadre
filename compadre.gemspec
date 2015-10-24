$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "compadre/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "compadre"
  s.version = Compadre::VERSION
  s.authors = ["Alex Stophel", "Jesse Pledger"]
  s.email = ["alexstophel@gmail.com", "jessepledger@gmail.com"]
  s.summary = "Flexible solution for friendship management in Rails."
  s.license = "MIT"
  s.files = `git ls-files`.split("\n")

  # Gem dependencies
  s.add_dependency "rails", "~> 4.2.4"

  # Development dependencies
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.0"
  s.add_development_dependency "shoulda-matchers", "~> 3.0"
  s.add_development_dependency "factory_girl_rails", "~> 4.5"
end
