# -*- coding: utf-8 -*-

#
# Robust unicode upcase/downcase
#

if RUBY_PLATFORM =~ /java/i
  require 'java'

  puts java.lang.System.getProperty('file.encoding')

  module CiteProc
    def upcase(string)
      java.lang.String.new(string).to_upper_case(java.util.Locale::ENGLISH).to_s
    end

    def downcase(string)
      java.lang.String.new(string).to_lower_case(java.util.Locale::ENGLISH).to_s
    end
  end

else

  module CiteProc
    def upcase(string)
      string.upcase
    end

    def downcase(string)
      string.downcase
    end
  end
end

module CiteProc
  module_function :upcase, :downcase
end
