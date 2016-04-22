Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_BadCitationUpdate to pass

  @citation @bugreports @citations
  Scenario: Bad Citation Update
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation
        disambiguate-add-year-suffix="true">
        <layout delimiter="; ">
          <names variable="author">
            <name initialize-with="."/>
          </names>
          <date variable="issued" date-parts="year" form="text" prefix=" "/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Grignon","given":"Cyril"},{"family":"Sentenac","given":"Corey"}],"id":"ITEM-0","issued":{"date-parts":[[2000]]},"type":"book"},{"author":[{"family":"Grignon","given":"Cyril"},{"family":"Sentenac","given":"Corey"}],"id":"ITEM-1","issued":{"date-parts":[[2000]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] C. Grignon, C. Sentenac 2000a
    >>[1] C. Grignon, C. Sentenac 2000b
    """
