Feature: punctuation
  As a CSL cite processor hacker
  I want the test punctuation_DateStripPeriods to pass

  @citation @punctuation
  Scenario: Date Strip Periods
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
          <date variable="issued">
            <date-part name="month" form="short" suffix=" " strip-periods="true"/>
    		<date-part name="year" form="long"/>
          </date>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["1965","6","1"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Jun 1965
    """
