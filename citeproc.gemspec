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
  s.description = 'A cite processor interface for Citation Style Language (CSL) styles.'
  s.licenses     = ['BSD-2-Clause']
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.required_ruby_version = '>= 3.1'
  s.add_dependency('namae', '~>1.0')
  s.add_dependency 'date'
  s.add_dependency 'forwardable'
  s.add_dependency 'json'
  s.add_dependency 'observer', '< 1.0'
  s.add_dependency 'open-uri', '< 1.0'

  s.files        = `git ls-files`.split("\n") - %w{
    .document
    .gitignore
    .rspec
    .simplecov
    .yardopts
    Gemfile
    Rakefile
    citeproc.gemspec
    cucumber.yml
  } - `git ls-files -- {.github,tasks,spec,features}/*`.split("\n")

  s.require_path = 'lib'
end

# vim: syntax=ruby
