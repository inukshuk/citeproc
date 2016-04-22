Feature: date
  As a CSL cite processor hacker
  I want the test date_LocalizedTextInStyleLocaleWithTextCase to pass

  @citation @date
  Scenario: Localized Text In Style Locale With Text Case
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
      <locale>
        <date form="text">
          <date-part name="day" suffix=" "/>
          <date-part name="month" suffix=" " text-case="uppercase"/>
          <date-part name="year"/>
        </date>
      </locale>
      <citation>
        <layout>
          <date date-parts="year-month" form="text" variable="issued">
            <date-part form="short" name="month" />
          </date>
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
    DEC. 2005
    """
