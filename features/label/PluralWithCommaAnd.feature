Feature: label
  As a CSL cite processor hacker
  I want the test label_PluralWithCommaAnd to pass

  @citation @label @citation-items
  Scenario: Plural With Comma And
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          page-range-format="expanded">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <group delimiter=" ">
            <label variable="locator"/>
            <text variable="locator"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"213, and 235"}]]
    """
    Then the results should be:
      | pages 213, and 235 |
