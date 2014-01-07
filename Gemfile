source 'https://rubygems.org'
gemspec

group :debug do
  gem 'debugger', '~>1.6', :platform => :mri
  gem 'rubinius-compiler', '~>2.0', :platform => :rbx
  gem 'rubinius-debugger', '~>2.0', :platform => :rbx
end

group :optional do
  gem 'chronic', '~>0.10'
  gem 'edtf', '~>2.0'

  gem 'bibtex-ruby', '~>3.0', :require => 'bibtex'

  gem 'simplecov', '~>0.8', :require => false
  gem 'rubinius-coverage', :platform => :rbx

  gem 'guard', '~>2.2'
  gem 'guard-rspec', '~>4.2'
  gem 'guard-cucumber', '~>1.4'

  gem 'redcarpet', '~>3.0', :platform => :mri

  gem 'unicode', '~>0.4', :platforms => [:mri, :mswin]
end

group :development do
  gem 'rake'
  gem 'cucumber'
  gem 'rspec'
end

group :extra do
  gem 'yard', '~>0.8', :platforms => :ruby
end

platform :rbx do
  gem 'rubysl', '~>2.0'
  gem 'rubysl-json', '~>2.0'
  gem 'racc'
end
