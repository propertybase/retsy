# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retsy/version'

Gem::Specification.new do |spec|
  spec.name          = "retsy"
  spec.version       = Retsy::VERSION
  spec.authors       = ["Leif Gensert"]
  spec.email         = ["leif@propertybase.com"]
  spec.summary       = %q{pure Ruby RETS library}
  spec.description   = %q{Gem to access the Real Estate Transaction Standard}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",              "< 1.0"
  spec.add_dependency "faraday-digestauth"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "faraday-conductivity"
  spec.add_dependency "multi_xml"

  spec.add_development_dependency "rspec", '~> 3.0'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
