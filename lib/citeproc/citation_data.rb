module CiteProc
	
	class CitationItem
		
		include Attributes
		
		attr_predicates :id, :locator, :label, :'suppress-author',
			:'author-only', :prefix, :suffix
				
		def to_citeproc
			attributes.stringify_keys
		end
		
		def to_json
			MultiJson.encode(to_citeproc)
		end
		
		def inspect
			"#<CiteProc::CitationItem id=#{id.to_s.inspect}>"
		end
		
	end
	
	class CitationData
		
		def to_citeproc
			{}
		end
		
		def to_json
			MultiJson.encode(to_citeproc)
		end
		
	end
	
end