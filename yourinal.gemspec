# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yourinal/version"

Gem::Specification.new do |s|
  s.name        = "yourinal"
  s.version     = Yourinal::VERSION
  s.authors     = ["Adam Bair"]
  s.email       = ["adambair@gmail.com"]
  s.homepage    = "http://github.com/adambair/yourinal"
  s.summary     = %q{Yourinal; Your Terminal - A collection tools and utilities for your terminal needs.}
  s.description = %q{Currenty only a progress indicator, more coming to your teriminal}

  s.rubyforge_project = "yourinal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
