# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vtiger-ruby/version"

Gem::Specification.new do |s|
  s.name        = "vtiger-ruby"
  s.version     = Vtiger::Ruby::VERSION
  s.authors     = ["Torey Heinz"]
  s.email       = ["torey@ihswebdesign.com"]
  s.homepage    = ""
  s.summary     = %q{Trying to create ruby friendly wrapper for vTiger}
  s.description = %q{Trying to create ruby friendly wrapper for vTiger}

  s.rubyforge_project = "vtiger-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
