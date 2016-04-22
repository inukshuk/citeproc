Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_SmallCaps to pass

  @citation @flipflop
  Scenario: Small Caps
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
          <group delimiter=", ">
            <text variable="title" font-variant="small-caps"/>
            <text variable="container-title"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"His <span style=\"font-variant:small-caps;\">Anthology</span>","id":"ITEM-1","title":"His <span style=\"font-variant:small-caps;\">Anonymous</span> Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    <span style="font-variant:small-caps;">His <span style="font-variant:normal;">Anonymous</span> Life</span>, His <span style="font-variant:small-caps;">Anthology</span>
    """
