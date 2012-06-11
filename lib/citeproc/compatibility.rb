
if RUBY_VERSION < '1.9'
  require 'enumerator'
  
  $KCODE = 'u'
  require 'jcode'
  
  def self.to_unicode(string)
    string.gsub(/\\?u([\da-f]{4})/i) { |m| [$1.to_i(16)].pack('U') }
  end

  def ruby_18; yield; end
  def ruby_19; false; end
  
  # Remove the 'id' and 'type' methods in Ruby 1.8
  class Object
    undef_method :id
    undef_method :type
  end
else
  
  module CiteProc
    def self.to_unicode(string)
			string
		end
  end
  
  def ruby_18; false; end
  def ruby_19; yield; end
end


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



module CiteProc
  # Robust unicode upcase/downcase
  if RUBY_PLATFORM == 'java'
    require 'java'

    def self.upcase(string)
      java.lang.String.new(string).to_upper_case(java.util.Locale::ENGLISH).to_s
    end

    def self.downcase(string)
      java.lang.String.new(string).to_lower_case(java.util.Locale::ENGLISH).to_s
    end    
  else
    begin
      require 'unicode'
  
      def self.upcase(string)
        Unicode.upcase(string)
      end
  
      def self.downcase(string)
        Unicode.downcase(string)
      end
    rescue LoadError
      begin
        require 'unicode_utils'

        def self.upcase(string)
          UnicodeUtils.upcase(string)
        end

        def self.downcase(string)
          UnicodeUtils.downcase(string)
        end
      rescue LoadError
        begin
          require 'active_support/multibyte/chars'
  
          def self.upcase(string)
            ActiveSupport::Multibyte::Chars.new(string).upcase.to_s
          end
  
          def self.downcase(string)
            ActiveSupport::Multibyte::Chars.new(string).downcase.to_s
          end    
        rescue LoadError
  
          def self.upcase(string)
            string.upcase
          end
  
          def self.downcase(string)
            string.downcase
          end
        end
      end
    end
  end
end