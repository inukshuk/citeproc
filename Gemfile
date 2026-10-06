source 'https://rubygems.org'
gemspec

group :debug do
  gem 'debug', '>= 1.0.0', require: false, platforms: :mri
  gem 'ruby-debug', require: false, platforms: :jruby
end

group :optional do
  gem 'nokogiri'
  gem 'edtf'
  gem 'bibtex-ruby', require: 'bibtex'
  gem 'citeproc-ruby', github: 'inukshuk/citeproc-ruby', branch: 'master'
  gem 'csl', github: 'inukshuk/csl-ruby', branch: 'master'
end

group :development do
  gem 'rake'
  gem 'cucumber'
  gem 'rspec'
  gem 'csl-styles', '~>2.0', require: false
end

group :coverage do
  gem 'simplecov', '>= 1.3', require: false
  gem 'simplecov-lcov', require: false
end
