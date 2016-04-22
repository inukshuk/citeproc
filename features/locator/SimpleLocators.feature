Feature: locator
  As a CSL cite processor hacker
  I want the test locator_SimpleLocators to pass

  @citation @locator @citation-items
  Scenario: Simple Locators
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
          <group delimiter=", ">
            <names variable="author">
              <name form="short" />
            </names>
            <text variable="title" />
            <date variable="issued">
              <date-part name="year" />
            </date>
            <group delimiter=" ">
              <label form="short" strip-periods="false" variable="locator" />
              <number variable="locator" />
            </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2000"]]},"title":"Book A","type":"book"},{"author":[{"family":"Roe","given":"Jane"}],"id":"ITEM-2","issued":{"date-parts":[["2001"]]},"title":"Book B","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","label":"page","locator":"100 - 103"},{"id":"ITEM-2","label":"chapter","locator":"200 - 201"}]]
    """
    Then the results should be:
      | Doe, Book A, 2000, pp. 100–103; Roe, Book B, 2001, chap. 200–201. |
