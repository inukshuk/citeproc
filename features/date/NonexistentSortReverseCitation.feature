Feature: date
  As a CSL cite processor hacker
  I want the test date_NonexistentSortReverseCitation to pass

  @citation @date
  Scenario: Nonexistent Sort Reverse Citation
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
        <sort>
          <key sort="ascending" variable="issued" />
          <key variable="title" />
        </sort>
        <layout delimiter="; ">
          <text variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Item 1","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[["1999","2","15"]]},"title":"Item 2","type":"book"},{"id":"ITEM-3","title":"Item 3","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[["2000","2","15"]]},"title":"Item 4","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Item 2; Item 4; Item 1; Item 3
    """
