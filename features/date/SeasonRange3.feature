Feature: date
  As a CSL cite processor hacker
  I want the test date_SeasonRange3 to pass

  @citation @date
  Scenario: Season Range3
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
    	  <date variable="issued" date-parts="year-month-day" form="text"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["1999","21"],["1999","22"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Spring–Summer 1999
    """
