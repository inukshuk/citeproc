require_relative 'lib/citeproc/version'

Gem::Specification.new do |s|
  s.name        = 'citeproc'
  s.version     = CiteProc::VERSION
  s.authors     = ['Sylvester Keil']
  s.email       = ['sylvester@keil.or.at']
  s.homepage    = 'https://github.com/inukshuk/citeproc'
  s.licenses    = ['BSD-2-Clause']
  s.summary     = 'A cite processor interface.'
  s.description = 'A cite processor interface for Citation Style Language (CSL) styles.'

  s.metadata = {
    'source_code_uri' => 'https://github.com/inukshuk/citeproc',
    'bug_tracker_uri' => 'https://github.com/inukshuk/citeproc/issues',
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = '>= 3.1'
  s.add_dependency 'namae', '~> 1.2'
  s.add_dependency 'date', '~> 3.0'
  s.add_dependency 'forwardable', '~> 1.3'
  s.add_dependency 'json', '>= 2.0'
  s.add_dependency 'observer', '< 1.0'
  s.add_dependency 'open-uri', '< 1.0'

  # Used by the CSL test-suite
  s.add_development_dependency 'citeproc-ruby', '~> 2.0'

  s.files = Dir[
    'lib/**/*.rb',
    'BSDL',
    'README.md'
  ]
end
