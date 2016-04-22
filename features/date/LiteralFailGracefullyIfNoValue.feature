Feature: date
  As a CSL cite processor hacker
  I want the test date_LiteralFailGracefullyIfNoValue to pass

  @citation @date
  Scenario: Literal Fail Gracefully If No Value
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
          <text value="Only Me" />
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
    [{"id":"ITEM-1","issued":{"date-parts":[]},"title":"Ignore me","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Only Me
    """
