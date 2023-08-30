# frozen_string_literal: true

require File.expand_path('../lib/omniauth-monday/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = "omniauth-monday"
  gem.version = Omniauth::Monday::VERSION
  gem.authors = ["Rob Race"]
  gem.email = ["rob@succinctsoftwarellc.com"]

  gem.summary = %q{Official OmniAuth strategy for Monday.com.}
  gem.description = %q{Official OmniAuth strategy for Monday.com.}
  gem.homepage = "https://github.com/rob-race/omniauth-monday"
  gem.license = "MIT"
  gem.required_ruby_version = ">= 2.6.0"

  gem.metadata["homepage_uri"] = gem.homepage

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-monday"
  gem.require_paths = ["lib"]

  gem.add_dependency 'omniauth', '~> 2.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.7'
  gem.add_dependency 'graphql-client'
end
