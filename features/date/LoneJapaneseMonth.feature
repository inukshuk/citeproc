Feature: date
  As a CSL cite processor hacker
  I want the test date_LoneJapaneseMonth to pass

  @citation @date
  Scenario: Lone Japanese Month
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
          <date variable="issued" form="text"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[],"raw":"7月1964"},"title":"My Title","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    July 1964
    """
