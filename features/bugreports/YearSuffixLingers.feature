Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_YearSuffixLingers to pass

  @citation @bugreports @citations
  Scenario: Year Suffix Lingers
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
      <citation 
             et-al-min="3"
             et-al-use-first="1"
             et-al-subsequent-min="3"
             et-al-subsequent-use-first="1"
             disambiguate-add-year-suffix="true">
        <layout delimiter="; ">
          <group delimiter=" ">
            <names variable="author">
              <name form="short"/>
            </names>
            <date  variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author" />
          <key variable="title" />
        </sort>
        <layout>
          <text value="Ignore me" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[["1990"]]},"title":"Book A","type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[["1990"]]},"title":"Book B","type":"book"},{"author":[{"family":"Jones","given":"Bob"}],"id":"ITEM-3","issued":{"date-parts":[["1990"]]},"title":"Book C","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Smith 1990a
    ..[1] Smith 1990b
    >>[2] Jones 1990
    """
