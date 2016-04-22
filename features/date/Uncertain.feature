Feature: date
  As a CSL cite processor hacker
  I want the test date_Uncertain to pass

  @citation @date
  Scenario: Uncertain
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
          <choose>
            <if is-uncertain-date="issued">
              <text value="circa" suffix=" "/>
            </if>
          </choose>
          <date variable="issued">
            <date-part name="day" suffix=" " />
            <date-part form="long" name="month" suffix=" " />
            <date-part name="year" />
          </date>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"circa":1,"date-parts":[[2005,12,15]]},"type":"book"},{"id":"ITEM-2","issued":{"date-parts":[[2005,12,20]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    circa 15 December 2005; 20 December 2005
    """
