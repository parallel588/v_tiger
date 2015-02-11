# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "v_tiger/version"

Gem::Specification.new do |s|
  s.name        = "v_tiger"
  s.version     = VTiger::VERSION
  s.authors     = ["Torey Heinz"]
  s.email       = ["torey@ihswebdesign.com"]
  s.homepage    = ""
  s.summary     = %q{A very Thin wrapper around the VTiger Web Services API}
  s.description = %q{A very Thin wrapper around the VTiger Web Services API}

  s.rubyforge_project = "v_tiger"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('httparty')
  s.add_dependency('activesupport')
  s.add_dependency('i18n')
  s.add_dependency('syck', '~> 1.0.5')

  s.add_development_dependency('rspec')
end
