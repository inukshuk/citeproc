# -*- coding: utf-8 -*-

unless Symbol.is_a?(Comparable)
  class Symbol
    include Comparable

    def =~(pattern)
      to_s =~ pattern
    end

    def <=>(other)
      return nil unless other.is_a?(Symbol)
      to_s <=> other.to_s
    end
  end
end



if RUBY_VERSION < '1.9'
  require 'enumerator'

  $KCODE = 'u'
  require 'jcode'

  module CiteProc

    def to_unicode(string)
      string.gsub(/\\?u([\da-f]{4})/i) { |m| [$1.to_i(16)].pack('U') }
    end

    def ruby_18
      yield
    end

    def ruby_19
      false
    end
    
    begin
      require 'oniguruma'
      
      def oniguruma
        Oniguruma::ORegexp.new(yield, :syntax => Oniguruma::SYNTAX_JAVA, :encoding => Oniguruma::ENCODING_UTF8)
      end
      
      def oniguruma?
        true
      end
    rescue LoadError
      def oniguruma
        false
      end
      alias oniguruma? oniguruma
    end
  end

  # Remove the 'id' and 'type' methods in Ruby 1.8
  class Object
    undef_method :id
    undef_method :type
  end

else

  module CiteProc
    def to_unicode(string)
      string
    end

    def ruby_18
      false
    end

    def ruby_19
      yield
    end
    
    def oniguruma
      Regexp.new(yield)
    end
    
    def oniguruma?
      true
    end
  end
end

#
# Robust unicode upcase/downcase
#

if RUBY_PLATFORM == 'java'
  require 'java'

  puts java.lang.System.getProperty('file.encoding')
  
  module CiteProc
    def upcase(string)
      java.lang.String.new(string).to_upper_case(java.util.Locale::ENGLISH).to_s
    end

    def downcase(string)
      java.lang.String.new(string).to_lower_case(java.util.Locale::ENGLISH).to_s
    end
    
    # def oniguruma
    #   Regexp.new(yield)
    # end
    # 
    # def oniguruma?
    #   true
    # end
  end

else

  module CiteProc
    private

    begin
      require 'unicode'

      def upcase(string)
        Unicode.upcase(string)
      end

      def downcase(string)
        Unicode.downcase(string)
      end
    rescue LoadError
      begin
        require 'unicode_utils'

        def upcase(string)
          UnicodeUtils.upcase(string)
        end

        def downcase(string)
          UnicodeUtils.downcase(string)
        end
      rescue LoadError
        begin
          require 'active_support/multibyte/chars'

          def upcase(string)
            ActiveSupport::Multibyte::Chars.new(string).upcase.to_s
          end

          def downcase(string)
            ActiveSupport::Multibyte::Chars.new(string).downcase.to_s
          end    
        rescue LoadError

          def upcase(string)
            string.upcase
          end

          def downcase(string)
            string.downcase
          end
        end
      end
    end
  end
end

module CiteProc
  module_function :ruby_18, :ruby_19, :oniguruma, :oniguruma?,
    :to_unicode, :upcase, :downcase
end
