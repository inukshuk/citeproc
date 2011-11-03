require 'uri'

module CiteProc
  module Asset
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    attr_accessor :asset
    
    alias to_s asset

    def inspect
      to_s.inspect
    end
    
    module ClassMethods
      
      attr_accessor :root, :extension, :prefix
      
      def load(asset)
        instance = new
        case
        when File.exists?(asset)
          instance.asset = read(asset)
        when File.exists?(File.join(root.to_s, extend_name(asset)))
          instance.asset = read(File.join(root.to_s, extend_name(asset)))
        else
          instance.asset = asset
        end
        instance
      end
      
      private

      def read(name)
        io = open(name, 'r:UTF-8')
        io.read
      ensure
        io.close
      end

      def extend_name(file)
        file = File.extname(file).empty? ? [file, extension].compact.join : file
        file = file.start_with?(prefix.to_s) ? file : [prefix,file].join
        file
      end
    end
    
  end
  
  class Style
    include Asset
    @root = '/usr/local/share/citation-style-language/styles'.freeze
    @extension = '.csl'.freeze
  end
  
  class Locale
    include Asset
    @root = '/usr/local/share/citation-style-language/locales'.freeze
    @extension = '.xml'.freeze
    @prefix = 'locales-'
  end
    
end
