# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'citeproc/version'

Gem::Specification.new do |s|
  s.name        = 'citeproc'
  s.version     = CiteProc::VERSION.dup
  s.platform    = Gem::Platform::RUBY

  s.required_ruby_version = '>= 1.9.3'

  s.authors     = ['Sylvester Keil']
  s.email       = ['sylvester@keil.or.at']

  s.homepage    = 'https://github.com/inukshuk/citeproc'
  s.summary     = 'A cite processor interface.'
  s.description =
    """
    A cite processor interface for Citation Style Language (CSL) styles.
    """

  s.license     = 'AGPL-3.0'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.add_runtime_dependency('namae', '~>1.0')

  s.files        = `git ls-files`.split("\n") - %w{
    .coveralls.yml
    .gitignore
    .travis.yml
    citeproc.gemspec
  }

  s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables  = []
  s.require_path = 'lib'

  s.has_rdoc      = 'yard'
end

# vim: syntax=ruby
