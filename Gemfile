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
  if RUBY_VERSION >= '2.2.2'
    gem 'edtf', '~>3.0'
  else
    gem 'edtf', '~>2.0'
  end

  gem 'bibtex-ruby', '~>4.0', :require => 'bibtex'

  gem 'pry'

  gem 'unicode', '>=0.4', '<1.0', :platforms => [:ruby, :mswin, :mingw]

  gem 'citeproc-ruby', :github => 'inukshuk/citeproc-ruby'
  #gem 'csl', :github => 'inukshuk/csl-ruby'
end

group :development do
  gem 'rake', '~>10.0'
  gem 'cucumber'
  gem 'rspec', '~>3.0'
  gem 'csl-styles', '~>1.0.1', :require => false
end

group :coverage do
  gem 'coveralls', :require => false
  gem 'simplecov', '~>0.8', :require => false
  gem 'rubinius-coverage', :platform => :rbx
end

group :extra do
  gem 'yard', '~>0.8', :platforms => :ruby
  gem 'redcarpet', '~>3.0', :platform => :mri
  gem 'guard', '~>2.2'
  gem 'guard-rspec', '~>4.2'
  gem 'guard-cucumber', '~>2.0'
end

group :rbx do
  gem 'rubysl', :platforms => :rbx
  gem 'racc', :platforms => :rbx
  gem 'json', '~>1.8', :platforms => :rbx
end
