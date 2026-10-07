source 'https://rubygems.org'
gemspec

# gem 'csl', github: 'inukshuk/csl-ruby', branch: 'master'
# gem 'citeproc-ruby', github: 'inukshuk/citeproc-ruby', branch: 'master'

group :development, :test do
  gem 'rake'
  gem 'cucumber'
  gem 'rspec'
  gem 'csl-styles', '~>2.0', require: false
end

group :debug do
  gem 'debug', require: false, platforms: :mri
end

group :optional do
  gem 'nokogiri'
  gem 'edtf'
  gem 'bibtex-ruby', require: 'bibtex'
end

group :coverage do
  gem 'simplecov', '>= 1.3', require: false
  gem 'simplecov-lcov', require: false
end
