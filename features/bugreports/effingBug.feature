Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_effingBug to pass

  @citation @bugreports @citation-items
  Scenario: effing Bug
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
          <group delimiter=", ">
            <text variable="title"/>
            <text variable="page" suffix=" f."/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"123","title":"Book One","type":"book"},{"id":"ITEM-2","page":"456","title":"Book Two","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"123"},{"id":"ITEM-2","locator":"123"}]]
    """
    Then the results should be:
      | Book One, 123 f.; Book Two, 456 f. |
