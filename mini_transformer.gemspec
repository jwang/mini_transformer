# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mini_transformer/version"

Gem::Specification.new do |s|
  s.name        = "mini_transformer"
  s.version     = MiniTransformer::VERSION
  s.authors     = ["John Wang"]
  s.email       = ["john@johntwang.com"]
  s.homepage    = "https://github.com/jwang/mini_transformer"
  s.summary     = %q{A converter for XML and JSON to HTML and JSON.}
  s.description = %q{A configurable converter for XML and JSON to HTML and JSON.}

  s.rubyforge_project = "mini_transformer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.executables   = %w(mini_transform)
  s.require_paths = ["lib"]
  # specify any dependencies here; for example:

   s.add_development_dependency "rspec"
   s.add_development_dependency 'guard-rspec'
   s.add_development_dependency 'mocha'
   #s.add_development_dependency 'rb-fsevent'
   #s.add_development_dependency 'growl_notify'
   s.add_development_dependency 'rake'
   s.add_development_dependency 'simplecov'
   
   s.add_runtime_dependency "nokogiri"
   s.add_runtime_dependency 'activesupport'
   s.add_runtime_dependency 'i18n'
   s.add_runtime_dependency 'json'
   s.add_runtime_dependency "thor"
end
