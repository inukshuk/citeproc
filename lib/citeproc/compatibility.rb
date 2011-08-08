unless Symbol.is_a?(Comparable)
  class Symbol
    include Comparable
    
    def <=>(other)
      return nil unless other.respond_to?(:to_s)
      to_s <=> other.to_s
    end
  end
end
