# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'aragog/version'

Gem::Specification.new do |s|
  s.name        = 'aragog'
  s.version     = Aragog::Version
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jared Pace']
  s.email       = ['jared@codeword.io']
  s.homepage    = 'http://github.com/jdpace/aragog'
  s.summary     = %q{Crawls your app looking bugs}
  s.description = %q{Crawls Rack applications and checks the responses for errors.}

  s.rubyforge_project = 'aragog'

  s.files         = `git ls-files`.split('\n')
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables   = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  # Runtime Dependencies
  s.add_runtime_dependency 'capybara', ['~> 0.4.1']

  # Developmnet Dependencies
  s.add_development_dependency 'rspec', ['~> 2.5.0']
  s.add_development_dependency 'mocha', ['~> 0.9.12']
  s.add_development_dependency 'watchr', ['~> 0.7']

end
