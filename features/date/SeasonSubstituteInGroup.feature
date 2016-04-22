Feature: date
  As a CSL cite processor hacker
  I want the test date_SeasonSubstituteInGroup to pass

  @citation @date
  Scenario: Season Substitute In Group
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
          <group prefix="(" suffix=")">
            <date variable="issued">
              <date-part name="month" />
              <date-part name="day" prefix=" " />
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[2000]],"season":3},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (Autumn)
    """
