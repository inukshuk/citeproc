require 'multi_json'

module CiteProc
  module Abbreviate
    
    attr_reader :abbreviations
    attr_accessor :default_namespace
    
    def abbreviations=(abbreviations)
      @abbreviations = case abbreviations
      when ::String
        MultiJson.decode(abbreviations, :symbolize_keys => true)
      when ::Hash
       abbreviations.deep_copy
      else raise ArgumentError, "failed to set abbreviations from #{abbreviations.inspect}"
      end
    end
    
    # call-seq:
    # abbreviate(namespace = :default, context, word)
    def abbreviate(*arguments)
      raise ArgumentError, "wrong number of arguments (#{arguments.length} for 2..3)" unless (2..3).include?(arguments.length)
      arguments.unshift(default_namespace || :default) if arguments.length < 3
      @abbreviations.deep_fetch(*arguments)
    end
    
    alias abbrev abbreviate

  end
end
