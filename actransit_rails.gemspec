# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'actransit_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "actransit_rails"
  spec.version       = ActransitRails::VERSION
  spec.authors       = ["Sanjay Y Patel"]
  spec.email         = ["sanjay.y.patel@gmail.com"]

  spec.summary       = %q{TODO: A gem for accessing the ACTransit API in Rails.}
  spec.description   = %q{TODO: Simplified access to the Bay Area's ACTransit API - details at http://api.actransit.org/transit/}
  spec.homepage      = "TODO: https://github.com/sanjayypatel/actransit_rails.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
