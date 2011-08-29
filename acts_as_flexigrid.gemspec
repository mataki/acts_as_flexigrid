# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_flexigrid/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_flexigrid"
  s.version     = ActsAsFlexigrid::VERSION
  s.authors     = ["Akihiro Matsumura"]
  s.email       = ["matsumura.aki@gmail.com"]
  s.homepage    = "https://github.com/mataki/acts_as_flexigrid"
  s.summary     = %q{ActiveRecord plugin to use easily Flexigrid that is jQuery plugin for grid table}
  s.description = %q{acts_as_flexigrid is ActiveRecord plugin for Flexigrid}

  s.rubyforge_project = "acts_as_flexigrid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', ['>= 3.0.0']
  s.add_dependency 'activerecord', ['>= 3.0.0']
  s.add_dependency 'kaminari', [">= 0"]
  s.add_development_dependency 'rake', [">= 0"]
  s.add_development_dependency 'sqlite3', ['>= 0']
  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'rspec', ['>= 0']
end
