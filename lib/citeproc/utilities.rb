module CiteProc

  module Utilities

    # call-seq:
    # process(mode = :bibliography, items, options = {})
    def process(*arguments)
    end

    def cite(items, options = {})
      process(:citation, items, options)
    end

    def bibliography(items, options = {})
      process(:bibliography, items, options)
    end

    # @param value [String, Boolean, nil] an xsd:boolean value
    # @param default [Boolean] the value if the value is not set
    # @return [Boolean] the boolean value
    def boolean(value, default = false)
      case value.to_s
      when 'true', '1' then true
      when 'false', '0' then false
      else default
      end
    end

  end

end
