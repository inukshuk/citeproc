Feature: date
  As a CSL cite processor hacker
  I want the test date_LocalizedDateFormats-ko-KR to pass

  @citation @date
  Scenario: Localized Date Formats-ko-KR
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
          <date-part name="year" suffix="&#45380;"/>
          <date-part name="month" form="numeric" prefix=" " suffix="&#50900;"/>
          <date-part name="day" prefix=" " suffix="&#51068;"/>
        </date>
        <date form="numeric">
          <date-part name="year"/>
          <date-part name="month" form="numeric-leading-zeros" prefix="/"/>
          <date-part name="day" form="numeric-leading-zeros" prefix="/"/>
        </date>
      </locale>
      <citation>
        <layout>
          <group delimiter="&#x0A;">
            <date variable="issued" form="text" date-parts="year-month-day"/>
            <date variable="issued" form="text" date-parts="year-month"/>
            <date variable="issued" form="text" date-parts="year"/>
            <date variable="issued" form="numeric" date-parts="year-month-day"/>
            <date variable="issued" form="numeric" date-parts="year-month"/>
            <date variable="issued" form="numeric" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[1998,4,10]]},"title":"BookA"}]
    """
    When I cite all items
    Then the result should be:
    """
    1998년 4월 10일
    1998년 4월
    1998년
    1998/04/10
    1998/04
    1998
    """
