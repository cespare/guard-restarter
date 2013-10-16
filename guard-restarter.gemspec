# -*- encoding: utf-8 -*-
require File.expand_path("../lib/guard/restarter", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "guard-restarter"
  gem.version       = Guard::Restarter::VERSION
  gem.authors       = ["Caleb Spare"]
  gem.license       = "MIT"
  gem.email         = ["cespare@gmail.com"]
  gem.description   =<<EOS
guard-restarter is a guard plugin to run a command (often a server) and restart it when files change.
EOS
  gem.summary       = %q{A guard-plugin to restart a server.}
  gem.homepage      = "https://github.com/cespare/guard-restarter"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "guard"
end
