Feature: date
  As a CSL cite processor hacker
  I want the test date_LocalizedNumericYearMonth to pass

  @citation @date
  Scenario: Localized Numeric Year Month
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
          <date date-parts="year-month" form="numeric" variable="issued" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[2005,12,15]]},"title":"Ignore me","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    12/2005
    """
