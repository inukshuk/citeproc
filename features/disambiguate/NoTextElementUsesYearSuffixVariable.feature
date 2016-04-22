Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_NoTextElementUsesYearSuffixVariable to pass

  @citation @disambiguate
  Scenario: No Text Element Uses Year Suffix Variable
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
          <names variable="author">
            <name form="short" />
          </names>
          <date variable="issued" prefix=" (" suffix=")">
            <date-part name="year" />
          </date>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2000"]]},"title":"Book A","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["2000"]]},"title":"Book B","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe (2000a); Doe (2000b)
    """
