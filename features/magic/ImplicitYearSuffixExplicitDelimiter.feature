Feature: magic
  As a CSL cite processor hacker
  I want the test magic_ImplicitYearSuffixExplicitDelimiter to pass

  @citation @magic
  Scenario: Implicit Year Suffix Explicit Delimiter
    Given the following style:
    """
    <?xml version="1.0" encoding="utf-8"?>
    <style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0">
       <info>
          <title>Molecular Ecology (dev)</title>
          <id>http://www.zotero.org/styles/Molecular Ecology</id>
          <link href="http://www.zotero.org/styles/Molecular Ecology" rel="self"/>
          <author>
             <name>myname</name>
             <email>myname@gmx.net</email>
          </author>
          <contributor>
             <name> Sebastian Karcher</name>
          </contributor>
          <category field="biology"/>
          <category field="generic-base"/>
          <updated>2011-04-06T02:21:30+00:00</updated>
          <rights>This work is licensed under a Creative Commons Attribution-Share Alike 3.0 License: http://creativecommons.org/licenses/by-sa/3.0/</rights>
       </info>
       <citation year-suffix-delimiter="," 
    			 disambiguate-add-year-suffix="true" 
    			 collapse="year-suffix" 
    			 disambiguate-add-names="true">
          <layout prefix="(" suffix=")" delimiter="; ">
            <date variable="issued">
               <date-part name="year"/>
            </date>
          </layout>
       </citation>
       <bibliography>
          <layout>
             <text value="dummy"/>
          </layout>
       </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[["1965"]]},"type":"book"},{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[["1965"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (1965a,b)
    """
