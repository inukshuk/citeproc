CiteProc
========
CiteProc is a cite processor interface and citation data API based on the
Citation Style Language (CSL) specifications. To actually process citations
a dedicated processor engine is required; a pure Ruby engine is available
in the [citeproc-ruby](https://rubygems/gems/citeproc-ruby) gem.

[![Build Status](https://secure.travis-ci.org/inukshuk/citeproc.png)](http://travis-ci.org/inukshuk/citeproc)


Quickstart
----------
Install CiteProc-Ruby and all official CSL styles (optional).

    $ [sudo] gem install citeproc
    $ [sudo] gem install csl-styles

Start rendering you references with any CSL style!

    require 'citeproc'
    require 'csl/styles'

    # Create a new processor with the desired style,
    # format, and locale.
    cp = CiteProc::Processor.new style: 'apa', format: 'html'

    # To see what styles are available in your current
    # environment, run `CSL::Style.ls'; this also works for
    # locales as `CSL::Locale.ls'.

    # Tell the processor where to find your references. In this
    # example we load them from a BibTeX bibliography using the
    # bibtex-ruby gem.
    cp.import BibTeX.open('./references.bib').to_citeproc



CSL Styles and Locales
----------------------
You can load CSL styles and locales by passing a respective XML string, file
name, or URL. You can also load styles and locales by name if the
corresponding files are installed in your local styles and locale directories.
By default, CSL-Ruby looks for CSL styles and locale files in

    /usr/local/share/csl/styles
    /usr/local/share/csl/locales

You can change these locations by changing the value of `CSL::Style.root` and
`CSL::Locale.root` respectively.

Alternatively, you can `gem install csl-styles` to install all official CSL
styles and locales. To make the styles and locales available, simply
`require 'csl/styles`.

Compatibility
-------------
The cite processor and the CSL API libraries have been developed for MRI,
Rubinius, and JRuby. Please note that we try to support only Ruby versions
1.9.3 and upwards.

Credits
-------
Thanks to Rintze M. Zelle, Sebastian Karcher, Frank G. Bennett, Jr.,
and Bruce D'Arcus of CSL and citeproc-js fame for their support!

Thanks to Google and the Berkman Center at Harvard University for supporting
this project as part of [Google Summer of Code](https://developers.google.com/open-source/soc/).

Copyright
---------
Copyright 2009-2014 Sylvester Keil. All rights reserved.

Copyright 2012 President and Fellows of Harvard College.

License
-------
CiteProc is dual licensed under the AGPL and the FreeBSD license.
