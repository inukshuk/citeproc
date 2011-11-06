
# CiteProc processes bibliographic data and formats it according to a style
# defined in CSL (Citation Style Language).
#
#
#
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
		
  end


	module Converters

		module_function
	
		def Item(item)
			item.is_a?(Item) ? item : Item.create(item)
		end
		
	end
	
end