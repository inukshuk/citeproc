source 'https://rubygems.org'
gemspec

group :debug do
  gem 'debugger', '~>1.1.3', :platform => [:mri_19, :mri_20]
end

group :optional do
	gem 'chronic', '~>0.6'
	gem 'edtf', '~>1.0.0'
		
	gem 'bibtex-ruby', '~>2.2.2', :require => 'bibtex'
	
  gem 'simplecov', '~>0.6.4'

  gem 'guard', '~>1.2'
  gem 'guard-rspec', '~>1.1'
  gem 'guard-cucumber', '~>1.2'

	gem 'yard', '~>0.8', :platforms => [:ruby_19, :ruby_20]
	gem 'redcarpet', '~>2.1', :platforms => [:mri_19, :mri_20]
  
  gem 'unicode_utils', '~>1.3.0', :platform => [:mri_19, :mri_20]
  gem 'unicode', '~>0.4.2', :platform => :mri_18
end

group :development do
  gem 'rake'
  gem 'cucumber'
  gem 'rspec'
end

group :extra do
  gem 'oniguruma', '~>1.1.0', :platform => :mri_18
end
