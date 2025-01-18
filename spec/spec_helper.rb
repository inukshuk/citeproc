begin
  require 'simplecov'
rescue LoadError
  # ignore
end

begin
  case
  when RUBY_PLATFORM == 'java'
    # require 'debug'
    # Debugger.start
  when defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'
    require 'rubinius/debugger'
  else
    require 'debug'
  end
rescue LoadError
  # ignore
end

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'tempfile'

require 'rspec'
require 'citeproc'
require 'citeproc/ruby'

require 'csl'
require 'csl/styles'

module Fixtures
	PATH = File.expand_path('../fixtures', __FILE__)

	Dir[File.join(PATH, '*.rb')].each do |fixture|
		require fixture
	end
end

RSpec.configure do |config|
  config.include(Fixtures)
end
