Feature: date
  As a CSL cite processor hacker
  I want the test date_RawParseSimpleDate to pass

  @citation @date
  Scenario: Raw Parse Simple Date
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
    [{"id":"ITEM-1","issued":{"date-parts":[],"raw":"Oct 28, 1958"},"title":"Ignore me","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (28 October 1958)
    """
