Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_NumberInMacroWithVerticalAlign to pass

  @citation @bugreports
  Scenario: Number In Macro With Vertical Align
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
      <macro name="edition-mac">
        <number variable="edition" font-style="italic"/>
      </macro>
      <citation>
        <layout delimiter="; ">
          <text macro="edition-mac" vertical-align="sup"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":"2","id":"ITEM-1","title":"His Anonymous Life","type":"book"},{"edition":"3-5","id":"ITEM-2","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    <sup><i>2</i></sup>; <sup><i>3</i>–<i>5</i></sup>
    """
