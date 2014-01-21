begin
  require 'simplecov'
  require 'coveralls' if ENV['CI']
rescue LoadError
  # ignore
end

begin
  case
  when RUBY_PLATFORM < 'java'
    require 'debug'
    Debugger.start
  when defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'
    require 'rubinius/debugger'
  else
    require 'debugger'
  end
rescue LoadError
  # ignore
end


$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'tempfile'

require 'rspec'
require 'citeproc'
