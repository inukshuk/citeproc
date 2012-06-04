begin
  require 'simplecov'
  require 'debugger'
rescue LoadError
  # ignore
end

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'rspec'
require 'citeproc'
