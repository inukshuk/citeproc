source 'https://rubygems.org'
gemspec

group :debug do
  if RUBY_VERSION >= '2.0'
    gem 'byebug', :require => false, :platforms => :mri
  else
    gem 'debugger', :require => false, :platforms => :mri
  end

  gem 'ruby-debug', :require => false, :platforms => :jruby

  gem 'rubinius-debugger', :require => false, :platforms => :rbx
  gem 'rubinius-compiler', :require => false, :platforms => :rbx
end

group :optional do
  gem 'nokogiri', '~>1.6'
  gem 'chronic', '~>0.10', :require => false
  gem 'edtf', '~>2.1'

  gem 'bibtex-ruby', '~>4.0', :require => 'bibtex'

  gem 'guard', '~>2.2'
  gem 'guard-rspec', '~>4.2'
  gem 'guard-cucumber', '~>2.0'

  gem 'pry'

  gem 'unicode', '~>0.4', :platforms => [:ruby, :mswin, :mingw]

  gem 'citeproc-ruby', :github => 'inukshuk/citeproc-ruby'
  #gem 'csl', :github => 'inukshuk/csl-ruby'
end

group :development do
  gem 'rake'
  gem 'cucumber'
  gem 'rspec', '~>2.0'
  gem 'simplecov', '~>0.8', :require => false
  gem 'rubinius-coverage', :platform => :rbx
  gem 'coveralls', :require => false
  gem 'csl-styles', '~>1.0.1', :require => false
end

group :extra do
  gem 'yard', '~>0.8', :platforms => :ruby
  gem 'redcarpet', '~>3.0', :platform => :mri
end

platform :rbx do
  gem 'rubysl', '~>2.0'
  gem 'json', '~>1.8'
  gem 'racc'
end
