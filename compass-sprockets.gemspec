# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "compass/sprockets/version"

Gem::Specification.new do |s|
  s.name        = "compass-sprockets"
  s.version     = Compass::Sprockets::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grady Kuhnline"]
  s.email       = ["heygrady@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/compass-sprockets"
  s.summary     = %q{ Compass extension for Sprockets }
  s.description = %q{ An integration of Sprockets with Compass for auto-compiling JavaScript assets }

  s.rubyforge_project = "compass-sprockets"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("compass")
  s.add_dependency("sprockets")
end