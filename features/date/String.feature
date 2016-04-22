Feature: date
  As a CSL cite processor hacker
  I want the test date_String to pass

  @citation @date
  Scenario: String
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
          <group delimiter=": ">
            <text value="date"/>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[],"raw":"Bogus Date"},"title":"Book A","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[],"raw":"2010-03-27"},"title":"Book B","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    date: Bogus Date; date: 2010
    """
