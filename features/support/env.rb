begin
  require 'simplecov'
  SimpleCov.start
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

require 'nokogiri'
require 'citeproc'
require 'citeproc/ruby'
require 'csl/styles'

module MimicksCiteProcJS
  def processor
    @processor ||= CiteProc::Processor.new :style => @style,
      :format => default_format, :locale => default_locale
  end

  def default_format
    unless @format
      @format = CiteProc::Ruby::Format.load('citeprocjs')
      @format.config[:bib_indent] = nil
    end

    @format
  end

  # Use the style's default locale, like citeproc-js does;
  # locales are loaded from the csl-styles gem.
  def default_locale
    (@style && @style[:'default-locale']) || 'en-US'
  end
end

World(MimicksCiteProcJS)

