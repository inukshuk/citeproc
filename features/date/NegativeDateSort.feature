Feature: date
  As a CSL cite processor hacker
  I want the test date_NegativeDateSort to pass

  @citation @date
  Scenario: Negative Date Sort
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
          <key variable="issued"/>
        </sort>
        <layout delimiter=", ">
          <date variable="issued" delimiter="-">
            <date-part name="year"/>
            <date-part name="month" form="numeric"/>
            <date-part name="day" form="numeric"/>
          </date>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[-100,7,13]]},"title":"BookA","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[[54,10,13]]},"title":"BookB","type":"book"},{"id":"ITEM-3","issued":{"date-parts":[[-44,3,15]]},"title":"BookC","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[[68,6,11]]},"title":"BookD","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    100BC-7-13, 44BC-3-15, 54AD-10-13, 68AD-6-11
    """
