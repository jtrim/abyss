# -*- encoding: utf-8 -*-
require File.expand_path('../lib/abyss/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jesse Trimble"]
  gem.email         = ["jesseltrimble@gmail.com"]
  gem.description   = %q{Manage arbitrarily-deep configurations through a friendly DSL.}
  gem.summary       = %q{Manage arbitrarily-deep configurations through a friendly DSL.}
  gem.homepage      = ""

  gem.add_dependency "activesupport", '~> 3.2.0'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "abyss"
  gem.require_paths = ["lib"]
  gem.version       = Abyss::VERSION
end
