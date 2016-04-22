Feature: number
  As a CSL cite processor hacker
  I want the test number_MixedPageRange to pass

  @citation @number
  Scenario: Mixed Page Range
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          page-range-format="chicago">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <text variable="page" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"142-145 & 235","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    142–45 &amp; 235
    """
