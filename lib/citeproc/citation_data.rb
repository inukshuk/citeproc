module CiteProc

	# CitationItems consititue the main input elements to CiteProc's processing
	# methods. In order to be processed correctly, an item must contain a valid
	# id attribute used to retrieve the item's bibliographic data. Additionally,
	# an item may include the following, optional, attributes:
	#
	# * locator: a string identifying a page number or other pinpoint location
	#   or range within the resource;
  #
	# * label: a label type, indicating whether the locator is to a page, a
	#   chapter, or other subdivision of the target resource. Valid labels are
	#   defined in CitationItem.labels
	#
	# * suppress-author: if true, author names will not be included in the
	#   citation output for this cite;
	#
	# * author-only: if true, only the author name will be included in the
	#   citation output for this cite -- this optional parameter provides a
	#   means for certain demanding styles that require the processor output
	#   to be divided between the main text and a footnote.
	#
	# * prefix: a string to print before this cite item;
	#
	# * suffix: a string to print after this cite item.
  #
	class CitationItem
		
		include Attributes
		
		@labels = [
			:book, :chapter, :column, :figure, :folio, :issue, :line, :note, :opus,
			:page, :paragraph, :part, :section, :'sub-verbo', :verse, :volume
		].freeze
		
		class << self
			attr_reader :labels			
		end
		
		attr_predicates :id, :locator, :label, :'suppress-author',
			:'author-only', :prefix, :suffix
		
		# Added by processor	
		attr_predicates :sortkeys, :postion, :'first-reference-note-number',
			:'near-note', :unsorted
		
		attr_accessor :data
		
		def initialize(attributes = nil)
			merge(attributes)
		end
		
		def initialize_copy(other)
			@attributes = other.attributes.deep_copy
		end
		
		def inspect
			"#<CiteProc::CitationItem #{id.to_s}, #{locator.to_s} >"
		end
		
	end
	
	
	
	
	class CitationData
		
		extend Forwardable
		include Enumerable
		
		@defaults = {
			:footnote => 0
		}.freeze
		
		@rb2cp = {
			:id => 'citationID',
			:items => 'citationItems',
			:sorted_items => 'sortedItems',
			:footnote => 'noteIndex',
			:options => 'properties'
		}
		
		@cp2rb = @rb2cp.invert.freeze
		@rb2cp.freeze
		
		class << self
			attr_reader :defaults, :cp2rb, :rb2cp
		end
		
		attr_accessor :id
		
		attr_reader :items, :options, :sorted_items
		
		alias properties options
		
		def_delegators :@items, :length, :empty?, :[]
		
		# Some delegators should return self
		[:push, :<<, :unshift, :concat].each do |m|
			define_method(m) do |*arguments|
				names.send(m, *arguments)
				self
			end
		end
		
		def each
			if block_given?
				items.each(&Proc.new)
				self
			else
				to_enum
			end
		end
		
		
		def initialize(attributes = nil, options = {})
			@options = CitationData.defaults.merge(options)
			@items, @sorted_items = [], []
			merge(attributes)
		end
		
		def initialize_copy(other)
			@options = other.options.dup
			@items = other.items.map(&:dup)
			@sorted_items = other.items.map(&:dup)
			@id = other.id.dup if other.processed?
		end
		
    def merge(other)
      return self if other.nil?
      
      case other
      when String, /^\s*\{/
        other = MulitJson.decode(other, :symbolize_keys => true)
      when Hash
				# do nothing
			when Array
				other = { :items => other }
      when Attributes
        other = other.to_hash
			else
				raise ParseError, "failed to merge citation data and #{other.inspect}"
      end

			other = convert_from_citeproc(other)
			
			items.concat(Array(other.delete(:items)).map { |i| CitationItem.create!(i) })
			sorted_items.concat(Array(other.delete(:sorted_items)))
			
			properties = other.delete(:options)
			options.merge!(convert_from_citeproc(Hash[properties])) unless properties.nil?

			@id = other[:id] if other.has_key?(:id)
			      
      self
    end
		
		alias update merge
		
		def processed?
			!!id
		end
		
		def index
			options[:footnote]
		end
		
		def footnote?
			options[:footnote] > 0
		end
		
		def to_citeproc
			cp = {}
			
			cp[CitationData.rb2cp[:items]] = items.map(&:to_citeproc)
			cp[CitationData.rb2cp[:options]] = { CitationData.rb2cp[:footnote] => index }
			
			cp[CitationData.rb2cp[:id]] = id if processed?
			
			cp
		end
		
		def to_json
			MultiJson.encode(to_citeproc)
		end
		
		alias to_s to_json
		
		def inspect
			"#<CiteProc::CitationData items=[#{length}]>"
		end
		
		private
		
		def convert_from_citeproc(hash)
			hash = hash.symbolize_keys
			
			CitationData.cp2rb.each do |cp, rb|
				cp = cp.to_sym
				hash[rb] = hash.delete(cp) if hash.has_key?(cp)
			end
			
			hash
		end
		
	end
	
end