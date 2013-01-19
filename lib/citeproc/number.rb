module CiteProc
  # A CiteProc Variable used for numeric values.
  class Number < Variable

	  MAX_ROMAN = 5000

    FACTORS = [
      ['m', 1000], ['cm', 900], ['d', 500], ['cd', 400],
      ['c',  100], ['xc',  90], ['l',  50], ['xl',  40],
      ['x',   10], ['ix',   9], ['v',   5], ['iv',   4],
      ['i',    1]
    ].freeze

		class << self
			def pluralize?(string)
				/\S\s*[,&-]\s*\S|\df/ === string
			end
			
			# @param number [#to_i] the number to convert
      # @return [String] roman equivalent of the passed-in number
      def romanize(number)
        number, roman = number.to_i, ''

        return number unless number > 0 || number < MAX_ROMAN

        FACTORS.each do |code, factor|
          count, number = number.divmod(factor)
          roman << (code * count)
        end

        roman
      end
		end
  end

end
