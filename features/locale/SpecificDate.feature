Feature: locale
  As a CSL cite processor hacker
  I want the test locale_SpecificDate to pass

  @citation @locale
  Scenario: Specific Date
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
       <locale xml:lang="en">
        <date form="text">
          <date-part name="year"/>
          <date-part name="month" form="long" prefix=" "/>
          <date-part name="day" prefix=" "/>
        </date>
      </locale>
      <citation>
        <layout>
          <text variable="title" suffix=": "/>
          <date variable="issued" date-parts="year-month-day" form="text" prefix="(" suffix=")"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["2000","6","18"]]},"title":"Sample Title","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Sample Title: (2000 June 18)
    """
