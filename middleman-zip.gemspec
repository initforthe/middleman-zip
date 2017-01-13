# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-zip"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tomislav Simnett"]
  s.email       = ["tom@initforthe.com"]
  s.homepage    = "https://github.com/initforthe/middleman-zip"
  s.summary     = %q{Zips build files for Middleman}
  s.description = %q{Creates individual zips for each html file, and optionally other file extensions}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.2.0"])

  # Additional dependencies
  s.add_runtime_dependency("rubyzip", ">= 1.2.0")
end
