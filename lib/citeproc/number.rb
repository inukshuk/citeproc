# -*- encoding: utf-8 -*-

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

    # Numbers (with optional prefixes and suffixes) or roman numerals
    RANGE_BOUND = /(?:[[:alnum:]]*\d[[:alnum:]]*|[ivxlcdm]+)/i

    # Ranges between numbers; escaped hyphens are not range delimiters
    RANGE = /(?<![[:alnum:]])#{RANGE_BOUND}\s*[–-]\s*#{RANGE_BOUND}(?![[:alnum:]])/

    PAGE_RANGE = /([[:alnum:]]+)\s*[–-]+\s*([[:alnum:]]+)/

    # A page number with optional prefix and suffix
    PAGE = /\A(\d*[[:alpha:]]+)?(\d+)([[:alpha:]]*)\z/

    ROMAN = /\A[ivxlcdm]+\z/i

    class << self
      def pluralize?(string)
        /\S[\s,&]\S|\df/.match?(string) || RANGE.match?(string)
      end

      # @param number [#to_i] the number to convert
      # @return [String, Integer] roman equivalent of the passed-in number;
      #   the number itself if it is out of range
      def romanize(number)
        number = number.to_i

        return number unless number > 0 && number < MAX_ROMAN

        FACTORS.map { |code, factor|
          count, number = number.divmod(factor)
          code * count
        }.join
      end

      # Formats the page ranges in pages according to format:
      #
      # * "chicago-15" (or "chicago") and "chicago-16": page ranges are
      #   abbreviated according to the Chicago Manual of Style rules.
      # * "expanded": Abbreviated page ranges are expanded to
      #   their non-abbreviated form: 42-45, 321-328, 2787-2816.
      # * "minimal": All digits repeated in the second number
      #   are left out: 42-45, 321-8, 2787-816.
      # * "minimal-two": As "minimal", but at least two digits
      #   are kept in the second number: 42-45, 321-28, 2787-816.
      #
      # Without a format only the range delimiter is replaced. Ranges
      # with different prefixes (e.g., "N110-5") keep a plain hyphen;
      # escaped hyphens ("\-") are not range delimiters.
      #
      # @param pages [String] the pages to format
      # @param format [String, nil] the page range format
      # @param delimiter [String] the range delimiter
      # @return [String, nil] the formatted pages
      def format_page_range(pages, format = nil, delimiter = '–')
        return if pages.nil?

        pages.to_s
          .gsub(PAGE_RANGE) { format_page_bounds($1, $2, format, delimiter) || "#{$1}-#{$2}" }
          .gsub('\\-', '-')
      end

      private

      # @return [String, nil] the formatted page range or nil if
      #   the bounds do not form a page range
      def format_page_bounds(from, to, format, delimiter)
        if ROMAN.match?(from) && ROMAN.match?(to)
          return "#{from}#{delimiter}#{to}"
        end

        f, t = PAGE.match(from), PAGE.match(to)

        # Ranges must have the same prefix on both sides
        return unless f && t && f[1] == t[1]

        # When there are suffixes or no format was
        # specified we only replace the delimiter
        if format.nil? || !f[3].empty? || !t[3].empty?
          return "#{from}#{delimiter}#{to}"
        end

        prefix = f[1]
        last = format_page_number(f[2], t[2].dup, format)

        # The prefix is repeated only for expanded ranges
        "#{prefix}#{f[2]}#{delimiter}#{prefix if format == 'expanded'}#{last}"
      end

      def format_page_number(f, t, format)
        dim = f.length
        delta = dim - t.length

        if delta >= 0
          t.prepend f[0, delta] unless delta.zero?

          format = 'chicago-15' if format == 'chicago'

          if format == 'chicago-15' || format == 'chicago-16'
            # Only the 15th edition expands four digit
            # numbers when three or more digits change
            changes = dim - f.chars.zip(t.chars).
              take_while { |a,b| a == b }.length if dim == 4

            format = case
              when dim < 3
                'expanded'
              when dim == 4 && format == 'chicago-15' && changes > 2
                'expanded'
              when f[-2, 2] == '00'
                'expanded'
              when f[-2] == '0'
                'minimal'
              else
                'minimal-two'
              end
          end

          case format
          when 'expanded'
            # nothing to do
          when 'minimal'
            t = t.each_char.drop_while.with_index { |c, i| c == f[i] }.join('')
          when 'minimal-two'
            if dim > 2
              t = t.each_char.drop_while.with_index { |c, i|
                c == f[i] && dim - i > 2
              }.join('')
            end
          else
            raise ArgumentError, "unknown page range format: #{format}"
          end
        end

        t
      end
    end

    def <=>(other)
      case
      when other.nil?
        1
      when numeric?
        if other.respond_to?(:to_i)
          to_i <=> other.to_i
        else
          nil
        end
      when other.is_a?(Variable) || other.is_a?(String)
        to_s <=> other.to_s
      else
        nil
      end
    end
  end

end
