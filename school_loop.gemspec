# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'school_loop/version'

Gem::Specification.new do |spec|
  spec.name        = "school_loop"
  spec.version     = SchoolLoop::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Mitch Dempsey']
  spec.email       = ['mitch@mitchdempsey.com']
  spec.licenses    = ['MIT']
  spec.homepage    = "https://github.com/webdestroya/school_loop"
  spec.summary     = "Client for School Loop API (OpenLoop)"
  spec.description = "Client for School Loop API (OpenLoop)"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.0'
  
  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware', '~> 0.9'
  #spec.add_dependency 'ox', '~> 2.2.1'
  spec.add_dependency 'nokogiri', '>= 1.5.2'
end
