
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
require 'citeproc/selector'
require 'citeproc/bibliography'

require 'citeproc/engine'
require 'citeproc/processor'
require 'citeproc/utilities'

CiteProc.extend CiteProc::Utilities
