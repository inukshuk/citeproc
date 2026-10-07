CiteProc
========
CiteProc is a cite processor interface and citation data API
based on the Citation Style Language (CSL) specifications.
To actually process citations a dedicated processor engine is required;
a pure Ruby engine is available in the
[citeproc-ruby](https://rubygems.org/gems/citeproc-ruby) gem.

Quickstart
----------
Install CiteProc-Ruby and all official CSL styles (optional).

    $ [sudo] gem install citeproc-ruby
    $ [sudo] gem install csl-styles

Start rendering your references with any CSL style!

    require 'citeproc'
    require 'csl/styles'
    require 'bibtex'

    # Create a new processor
    # with the desired style, format, and locale.
    cp = CiteProc::Processor.new style: 'apa', format: 'text'

    # To see what styles are available in your current environment,
    # run `CSL::Style.ls';
    # this also works for locales as `CSL::Locale.ls'.

    # Tell the processor where to find your references.
    # In this example we load them from a BibTeX bibliography
    # using the bibtex-ruby gem (`gem install bibtex-ruby').
    cp.import BibTeX.open('./references.bib').to_citeproc

    # Now you are ready for rendering;
    # the processor API provides two main rendering methods:
    # `process' and `bibliography'.

    # For simple one-off renditions,
    # you can also call `render' in bibliography or citation mode:
    cp.render :bibliography, id: 'knuth'

    # This will return a rendered reference, like:
    #-> Knuth, D. (1968). The art of computer programming (Vol. 1). Addison-Wesley.

    # CiteProc-Ruby exposes a full CSL API to you;
    # this makes it possible to just alter CSL styles on the fly.
    # For example, what if we want names not to be initialized
    # even though APA style is configured to do so?
    # We could change the CSL style itself,
    # but we can also make a quick adjustment at runtime:
    cp.engine.style.macros['author-bib'].each_descendant do |node|
      node[:initialize] = 'false' if node.nodename == 'name'
    end

    # What just happened?
    # We selected the current style's 'author-bib' macro
    # and changed all of its CSL name nodes;
    # the cite processor output will pick-up the changes right away:

    cp.render :bibliography, id: 'knuth'
    #-> Knuth, Donald. (1968). The art of computer programming (Vol. 1). Addison-Wesley.

    # Note that we have picked 'text' as the output format;
    # if we want to make use of richer output formats
    # we can switch to HTML instead:
    cp.engine.format = 'html'

    cp.render :bibliography, id: 'knuth'
    #-> Knuth, Donald. (1968). <i>The art of computer programming</i> (Vol. 1). Addison-Wesley.

    # You can also render citations on the fly.
    cp.render :citation, id: 'knuth', locator: '23', label: 'page'
    #-> (Knuth, 1968, p. 23)

Documentation
-------------
* [CiteProc Documentation](https://rubydoc.info/gems/citeproc/)
* [CiteProc-Ruby API Documentation](https://rubydoc.info/gems/citeproc-ruby/)
* [CSL-Ruby API Documentation](https://rubydoc.info/gems/csl/)

Optional Dependencies
---------------------
CiteProc-Ruby tries to minimize hard dependencies for increased compatibility.
You can speed up the XML parsing by installing
[Nokogiri](https://rubygems.org/gems/nokogiri);
otherwise the REXML from the Ruby standard library will be used.

Similarly, you can install the
[EDTF](https://rubygems.org/gems/edtf)
gem to support a wide range of additional inputs for date variables.

CSL Styles and Locales
----------------------
You can load CSL styles and locales
by passing a respective XML string, file name, or URL.
You can also load styles and locales by name
if the corresponding files are installed
in your local styles and locale directories.
By default, CSL-Ruby looks for CSL styles and locale files in

    /usr/local/share/csl/styles
    /usr/local/share/csl/locales

You can change these locations
by changing the value of `CSL::Style.root` and `CSL::Locale.root` respectively.

Alternatively, you can `gem install csl-styles`
to install all official CSL styles and locales.
To make the styles and locales available,
simply `require 'csl/styles'`.

Development
-----------
To get started, install the development dependencies and run all tests:

    $ bundle install
    $ bundle exec rake

The [CSL test-suite](https://github.com/citation-style-language/test-suite)
runs as Cucumber features using CiteProc-Ruby:

    $ bundle exec cucumber

Credits
-------
Thanks to Rintze M. Zelle, Sebastian Karcher, Frank G. Bennett, Jr.,
and Bruce D'Arcus of CSL and citeproc-js fame
for their support!

Thanks to Google and the Berkman Center at Harvard University
for supporting this project as part of
[Google Summer of Code](https://developers.google.com/open-source/soc/).

Copyright
---------
Copyright 2009-2026 Sylvester Keil.
All rights reserved.

Copyright 2012 President and Fellows of Harvard College.

License
-------
CiteProc is dual licensed under the AGPL and the FreeBSD license.
