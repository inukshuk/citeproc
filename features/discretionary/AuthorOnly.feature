Feature: discretionary
  As a CSL cite processor hacker
  I want the test discretionary_AuthorOnly to pass

  @citation @discretionary @citation-items
  Scenario: Author Only
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
        <layout prefix="(" suffix=")">
          <group delimiter=" ">
            <names font-style="italic" suffix="!" variable="author">
              <name />
            </names>
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2005"]]},"title":"Book A","type":"book"},{"author":[{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["2000"]]},"title":"Book B","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"author-only":1,"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | John Smith!  |
      | (<i>Robert Jones</i>! 2000) |
