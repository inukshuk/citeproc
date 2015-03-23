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
  when RUBY_VERSION < '2.0'
    require 'debugger'
  else
    require 'byebug'
  end
rescue LoadError
  # ignore
end

require 'nokogiri'
require 'citeproc'
require 'citeproc/ruby'
require 'csl/styles'

module MimicksCiteProcJS
  def processor
    @processor ||= CiteProc::Processor.new :style => @style,
      :format => default_format, :locale => default_locale_path
  end

  def default_format
    unless @format
      @format = CiteProc::Ruby::Format.load('citeprocjs')
      @format.config[:bib_indent] = nil
    end

    @format
  end

  def default_locale_path
    File.expand_path('../../../spec/fixtures/locales/locales-en-US.xml', __FILE__)
  end

  def default_locale
    @locale ||= CSL::Locale.load default_locale_path
  end
end

World(MimicksCiteProcJS)

