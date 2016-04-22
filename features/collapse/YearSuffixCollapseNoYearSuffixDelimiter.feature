Feature: collapse
  As a CSL cite processor hacker
  I want the test collapse_YearSuffixCollapseNoYearSuffixDelimiter to pass

  @citation @collapse @citation-items
  Scenario: Year Suffix Collapse No Year Suffix Delimiter
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
             collapse="year-suffix-ranged"
             disambiguate-add-year-suffix="true">
        <layout delimiter=";">
          <group delimiter=" ">
            <names variable="author">
              <name form="short" />
            </names>
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
          <text variable="year-suffix" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2000"]]},"title":"Paper 1","type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["2000"]]},"title":"Paper 2","type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[["2000"]]},"title":"Paper 3","type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-4","issued":{"date-parts":[["2000"]]},"title":"Paper 4","type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-5","issued":{"date-parts":[["2000"]]},"title":"Paper 5","type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-6","issued":{"date-parts":[["2001"]]},"title":"Paper 6","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"},{"id":"ITEM-3"},{"id":"ITEM-4"},{"id":"ITEM-5"},{"id":"ITEM-6"}],[{"id":"ITEM-1"},{"id":"ITEM-3"},{"id":"ITEM-4"},{"id":"ITEM-5"},{"id":"ITEM-6"}]]
    """
    Then the results should be:
      | Smith 2000a–e;2001  |
      | Smith 2000a;c–e;2001 |
