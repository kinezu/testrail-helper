# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'testrail_helper/version'

Gem::Specification.new do |spec|
  spec.name          = "testrail_helper"
  spec.version       = TestrailHelper::VERSION
  spec.authors       = ["kinezu"]

  spec.summary       = "A tool to help get and parse testrail data"
  spec.description   = "A tool to help get and parse testrail data"
  spec.homepage      = "https://github.com/kinezu/testrail_helper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'json'
  spec.add_dependency 'testrail_client'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
