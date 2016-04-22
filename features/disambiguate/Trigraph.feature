Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_Trigraph to pass

  @citation @disambiguate @citations
  Scenario: Trigraph
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
      <citation disambiguate-add-year-suffix="true">
        <layout>
          <text variable="citation-label" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","issued":{"date-parts":[[2002]]},"type":"book"},{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-2","issued":{"date-parts":[[2002]]},"type":"book"},{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-3","issued":{"date-parts":[[2002]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Aalt02a
    ..[1] Aalt02b
    >>[2] Aalt02c
    """
