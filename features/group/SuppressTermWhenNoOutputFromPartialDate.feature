Feature: group
  As a CSL cite processor hacker
  I want the test group_SuppressTermWhenNoOutputFromPartialDate to pass

  @citation @group
  Scenario: Suppress Term When No Output From Partial Date
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
          <text value="Only this"/>
          <group>
            <text value=" (and not this)"/>
            <date variable="issued">
              <date-part name="month"/>
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["1965"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Only this
    """
