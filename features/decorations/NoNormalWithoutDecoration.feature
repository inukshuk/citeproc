Feature: decorations
  As a CSL cite processor hacker
  I want the test decorations_NoNormalWithoutDecoration to pass

  @citation @decorations
  Scenario: No Normal Without Decoration
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
        <layout font-weight="normal">
    	  <group delimiter="&#x0A;">
    	    <text variable="title" font-style="normal"/>
    	    <text variable="title" font-style="italic"/>
            <group font-style="italic">
              <text variable="title" font-style="normal"/>
            </group>
     	  </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    His Anonymous Life
    <i>His Anonymous Life</i>
    <i><span style="font-style:normal;">His Anonymous Life</span></i>
    """
