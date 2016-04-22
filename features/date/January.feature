Feature: date
  As a CSL cite processor hacker
  I want the test date_January to pass

  @citation @date
  Scenario: January
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
          <date variable="issued" form="text" date-parts="year-month-day"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["1965","1","30"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    January 30, 1965
    """
