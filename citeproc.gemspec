# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'citeproc/version'

Gem::Specification.new do |s|
  s.name        = 'citeproc'
  s.version     = CiteProc::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  
  s.authors     = ['Sylvester Keil']
  s.email       = ['sylvester@keil.or.at']
  
  s.homepage    = 'https://github.com/inukshuk/citeproc'
  s.summary     = 'A cite processor interface.'
  s.description =
    """
    A cite processor interface for Citation Style Language (CSL) styles.
    """

  s.license     = 'AGPL'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.add_runtime_dependency('multi_json', '~>1.3.5')
  s.add_runtime_dependency('namae', '~>0.1')
  
  s.add_development_dependency('cucumber', ['~>1.2.0'])
  s.add_development_dependency('rspec', ['~>2.10.0'])
  s.add_development_dependency('watchr', ['~>0.7'])
  s.add_development_dependency('rake', ['~>0.9.2'])
  s.add_development_dependency('yard', ['~>0.8.1'])

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables  = []
  s.require_path = 'lib'

  s.has_rdoc      = 'yard'
end

# vim: syntax=ruby