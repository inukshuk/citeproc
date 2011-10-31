CiteProc
========

The CiteProc gem is a Ruby abstraction layer for the JSON API used by citeproc-js. To process citations you also require a dedicate processor engine available as a separate gem: these will include citeproc-js, citeproc-ruby and eventually citeproc-hs. As work on these packages is still in progress, please be aware of the following caveats: the 0.0.2 release of citeproc-ruby is still a standalone package and will conflict with this release of citeproc; support will be added in future versions. The citeproc-js gem currently works only in JRuby (using an embedded version of the Rhino JavaScript interpreter) but is going to support other versions of Ruby using different JavaScript runtimes.
