$:.push File.expand_path('../lib', __FILE__)
require 'lyre/version'

Gem::Specification.new do |s|
  s.name         = 'lyre'
  s.version      = Lyre::VERSION
  s.authors      = ['Sortfolio, Inc.']
  s.email        = ['dev@sortfolio.com']
  s.homepage     = ''
  s.summary      = 'Awesome mocks of external REST API dependencies'
  s.description  = 'Awesome mocks of external REST API dependencies'

  s.required_ruby_version = ">= 1.9.2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'sinatra'
  s.add_dependency 'capybara'
  s.add_dependency 'thin'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'debugger'
end
