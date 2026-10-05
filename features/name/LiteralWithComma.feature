Feature: name
  As a CSL cite processor hacker
  I want the test name_LiteralWithComma to pass

  @bibliography @name @citation-items
  Scenario: Literal With Comma
    Given the following style:
    """
    <?xml version="1.0" encoding="utf-8"?>
    <style xmlns="http://purl.org/net/xbiblio/csl" version="1.0" class="note">
      <info>
        <title>United Kingdom</title>
        <id>http://citationstylist.org/modules/juris-gb</id>
        <link href="http://citationstylist/modules/juris-gb" rel="self"/>
        <link href="http://juris-m.github.io" rel="documentation"/>
        <author>
          <name>Frank Bennett</name>
          <email>biercenator@gmail.com</email>
        </author>
        <category citation-format="note"/>
        <category field="law"/>
        <summary>Juris-M style module for the United Kingdom</summary>
        <updated>2013-01-26T22:06:38+00:00</updated>
        <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
      </info>
      
      <citation>
        <layout>
          <names variable="author">
            <name/>
          </names>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author"/>
        </sort>
        <layout>
          <names variable="author">
            <name/>
          </names>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"literal":"Smith, John"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Kent","given":"Klark"}],"id":"ITEM-2","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Klark Kent</div>
      <div class="csl-entry">Smith, John</div>
    </div>
    """
