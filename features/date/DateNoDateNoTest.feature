Feature: date
  As a CSL cite processor hacker
  I want the test date_DateNoDateNoTest to pass

  @citation @date
  Scenario: Date No Date No Test
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
          <date prefix="(" suffix=")" variable="issued">
            <date-part form="long" name="month" />
            <date-part name="day" suffix=", " />
            <date-part name="year" />
          </date>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Ignore me","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    [CSL STYLE ERROR: reference with no printed form.]
    """
