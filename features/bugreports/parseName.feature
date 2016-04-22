Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_parseName to pass

  @bibliography @bugreports
  Scenario: parse Name
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <text value="Bogus"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=" ">
            <names variable="author">
              <name name-as-sort-order="all"/>
            </names>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"van Happel","given":"Eduard","parse-names":0}],"id":"ITEM-1","issued":{"date-parts":[[2008,1]]},"type":"article-journal"},{"author":[{"family":"von Hoppel","given":"Gustav"}],"id":"ITEM-2","issued":{"date-parts":[[2008,1]]},"type":"article-journal"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">van Happel, Eduard 2008</div>
      <div class="csl-entry">Hoppel, Gustav von 2008</div>
    </div>
    """
