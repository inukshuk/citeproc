Feature: plural
  As a CSL cite processor hacker
  I want the test plural_LabelForced to pass

  @citation @plural @citation-items
  Scenario: Label Forced
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
          <group delimiter=" ">
            <label variable="locator" plural="never" form="short"/>
            <text variable="locator"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"32-34"}]]
    """
    Then the results should be:
      | p. 32–34 |
