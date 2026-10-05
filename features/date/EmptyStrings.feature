Feature: date
  As a CSL cite processor hacker
  I want the test date_EmptyStrings to pass

  @citation @date @citation-items
  Scenario: Empty Strings
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
          <date variable="issued" date-parts="year-month-day" form="numeric"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["2000","",""]]},"type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | 2000 |
