Feature: name
  As a CSL cite processor hacker
  I want the test name_HebrewAnd to pass

  @citation @name
  Scenario: Hebrew And
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
      <locale>
        <terms>
          <term name="and">ו&#8200;</term>
        </terms>
      </locale>
      <citation>
        <layout>
          <names variable="author">
            <name and="text"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"תפוח"},{"family":"תפוז"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    תפוחו תפוז
    """
