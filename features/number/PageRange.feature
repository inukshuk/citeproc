Feature: number
  As a CSL cite processor hacker
  I want the test number_PageRange to pass

  @citation @number
  Scenario: Page Range
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
        <layout>
          <text variable="page" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"42-45","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    42–45
    """
