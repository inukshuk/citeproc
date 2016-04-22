Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_CitationLabelDefault to pass

  @citation @disambiguate
  Scenario: Citation Label Default
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
             disambiguate-add-year-suffix="true">
        <layout delimiter="; ">
            <text variable="citation-label"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Asthma","given":"Albert","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1900"]]},"title":"Book A","type":"book"},{"author":[{"family":"Asthma","given":"Zeppo","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1900"]]},"title":"Book B","type":"book"},{"author":[{"family":"Bronchitis","given":"Buffy","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[["2000"]]},"title":"Book C","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Asth00a; Asth00b; Bron00
    """
