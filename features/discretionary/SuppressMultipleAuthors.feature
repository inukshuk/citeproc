Feature: discretionary
  As a CSL cite processor hacker
  I want the test discretionary_SuppressMultipleAuthors to pass

  @citation @discretionary @citation-items
  Scenario: Suppress Multiple Authors
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
      <citation collapse="year">
        <layout delimiter=", " prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name />
              <substitute>
                <text variable="title" />
              </substitute>
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
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[["2005"]]},"title":"Book A","type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[["2006"]]},"title":"Book B","type":"book"},{"author":[{"family":"Jones","given":"Robert"}],"id":"ITEM-3","issued":{"date-parts":[["2000"]]},"title":"Book C","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","suppress-author":1},{"id":"ITEM-2"}],[{"id":"ITEM-3"}]]
    """
    Then the results should be:
      | (2005, 2006)        |
      | (Robert Jones 2000) |
