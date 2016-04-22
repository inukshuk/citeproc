Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_BasedOnSubsequentFormWithLocator to pass

  @citation @disambiguate @citation-items
  Scenario: Based On Subsequent Form With Locator
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
        <layout delimiter="; " suffix=".">
          <choose>
            <if position="subsequent">
              <names variable="author">
                <name form="short" />
              </names>
              <choose>
                <if disambiguate="true">
                  <text prefix=", " variable="title" />
                </if>
              </choose>
              <text prefix=", " suffix=" " value="supra note" />
              <text variable="first-reference-note-number" />
              <group>
                <text value="at" prefix=", " suffix=" "/>
                <text variable="locator"/>
              </group>
            </if>
            <else>
              <names variable="author">
                <name />
              </names>
              <text prefix=", " variable="title" />
              <text variable="locator" prefix=" "/>
              <date variable="issued">
                <date-part name="year" prefix=" (" suffix=")" />
              </date>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2000"]]},"title":"His Book","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["2001"]]},"title":"His Other Book","type":"book"},{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[["1998"]]},"title":"Her Book","type":"book"},{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-4","issued":{"date-parts":[["1999"]]},"title":"Her Other Book","type":"book"},{"author":[{"family":"Noakes","given":"John","static-ordering":false}],"id":"ITEM-5","issued":{"date-parts":[["1730"]]},"title":"His Book","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"12","note-number":"1"},{"id":"ITEM-2","locator":"23","note-number":"1"}],[{"id":"ITEM-5","locator":"34","note-number":"2"}],[{"id":"ITEM-3","locator":"45","note-number":"2"}],[{"id":"ITEM-4","locator":"56","note-number":"3"}],[{"first-reference-note-number":"1","id":"ITEM-1","locator":"67","note-number":"4","position":1}],[{"first-reference-note-number":"2","id":"ITEM-3","locator":"78","note-number":"5","position":1}],[{"first-reference-note-number":"2","id":"ITEM-5","locator":"89","note-number":"5","position":1}]]
    """
    Then the results should be:
      | John Doe, His Book 12 (2000); John Doe, His Other Book 23 (2001). |
      | John Noakes, His Book 34 (1730).     |
      | Jane Roe, Her Book 45 (1998).        |
      | Jane Roe, Her Other Book 56 (1999).  |
      | Doe, His Book, supra note 1, at 67.  |
      | Roe, Her Book, supra note 2, at 78.  |
      | Noakes, supra note 2, at 89.         |
