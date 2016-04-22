Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_BoldfaceNodeLevelMarkup to pass

  @citation @flipflop
  Scenario: Boldface Node Level Markup
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
        <layout prefix="Speak, " suffix=", and enter." font-weight="bold">
          <text value="&#60;b&#62;friend&#60;/b&#62;"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    <b>Speak, <span style="font-weight:normal;">friend</span>, and enter.</b>
    """
