# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'userland_client/version'

Gem::Specification.new do |spec|
  spec.name          = "userland_client"
  spec.version       = UserlandClient::VERSION
  spec.authors       = ["Joshua Szmajda"]
  spec.email         = ["josh@optoro.com"]
  spec.description   = %q{Client for userland}
  spec.summary       = %q{Client for userland}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "virtus"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
