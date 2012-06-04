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
