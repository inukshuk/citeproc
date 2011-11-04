
require 'multi_json'
require 'forwardable'


require 'citeproc/version'

require 'citeproc/compatibility'
require 'citeproc/extensions'

require 'citeproc/errors'

require 'citeproc/abbreviate'
require 'citeproc/attributes'

require 'citeproc/variable'
require 'citeproc/date'
require 'citeproc/names'

CiteProc::Variable.class_eval do
	@factories = Hash.new { |h,k| h.fetch(k.to_sym, CiteProc::Variable) }.merge(
		Hash[*@types.map { |n,k|
			[n, CiteProc.const_get(k.to_s.capitalize)]
		}.flatten]
	).freeze
end

require 'citeproc/item'
require 'citeproc/citation_data'
require 'citeproc/selector'
require 'citeproc/bibliography'
require 'citeproc/assets'

require 'citeproc/engine'
require 'citeproc/processor'
require 'citeproc/utilities'

CiteProc.extend CiteProc::Utilities
