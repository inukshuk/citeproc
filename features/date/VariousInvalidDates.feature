Feature: date
  As a CSL cite processor hacker
  I want the test date_VariousInvalidDates to pass

  @citation @date
  Scenario: Various Invalid Dates
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
        <layout delimiter="; ">
          <text value="Date: ("/>
          <date variable="issued">
            <date-part name="month" form="long" strip-periods="true"/>
          </date>
          <text value=")"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[1965,-1,1]]},"type":"book"},{"id":"ITEM-2","issued":{"date-parts":[[1965,13,1]]},"type":"book"},{"id":"ITEM-3","issued":{"date-parts":[[1965,17,1]]},"type":"book"},{"id":"ITEM-4","issued":{"date-parts":[[1965,60,1]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Date: (); Date: (Spring); Date: (Spring); Date: ()
    """
