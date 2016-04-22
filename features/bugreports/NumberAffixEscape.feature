Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_NumberAffixEscape to pass

  @citation @bugreports
  Scenario: Number Affix Escape
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
            <number variable="edition" prefix="ª"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":"2","id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (<sup>a</sup>2)
    """
