# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chart/version'

Gem::Specification.new do |spec|
  spec.name          = "chart"
  spec.version       = Chart::VERSION
  spec.authors       = ["Bryan Lim"]
  spec.email         = ["ytbryan@gmail.com"]
  spec.summary       = %q{add beautiful and reusable charts with one line of ruby  Charts from ChartJS.}
  spec.description   = %q{Add beautiful and reusable charts with one line of ruby https://github.com/ytbryan/chart}
  spec.homepage      = "http://github.com/ytbryan/chart"
  spec.license       = "MIT"
  spec.files         = Dir["{app,lib,vendor}/**/*", "LICENSE.txt", "README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
