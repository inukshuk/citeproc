Feature: locator
  As a CSL cite processor hacker
  I want the test locator_SingularEmbeddedLabelAfterPlural to pass

  @citation @locator @citation-items
  Scenario: Singular Embedded Label After Plural
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
          <text variable="title"/>
          <group delimiter=" ">
            <label variable="locator"/>
            <text variable="locator"/>
          </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book One","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"367-368, fig. 333"}]]
    """
    Then the results should be:
      | Book One, pages 367–368, fig. 333 |
