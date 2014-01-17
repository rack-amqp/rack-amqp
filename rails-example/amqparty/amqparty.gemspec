# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amqparty/version'

Gem::Specification.new do |spec|
  spec.name          = "amqparty"
  spec.version       = AMQParty::VERSION
  spec.authors       = ["Joshua Szmajda"]
  spec.email         = ["josh@optoro.com"]
  spec.description   = %q{Drop-in replacement for HTTParty to talk to Rack-AMQP}
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pry"
  spec.add_dependency "httparty"
  spec.add_dependency "rack-amqp-client"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
