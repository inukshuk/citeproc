Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_QuotesNodeLevelMarkup to pass

  @citation @flipflop
  Scenario: Quotes Node Level Markup
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
      <macro name="passphrase">
        <group  prefix="Speak, " suffix=", and enter.">
          <text  value="&#34;friend&#34;"/>
          <text value=" of mine on this day, "/>
          <date variable="issued" form="text"/>
        </group>
      </macro>
      <citation>
        <layout>
          <text macro="passphrase" quotes="true"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[1973,3,15]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    “Speak, ‘friend’ of mine on this day, March 15, 1973, and enter.”
    """
