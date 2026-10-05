Feature: locator
  As a CSL cite processor hacker
  I want the test locator_WithLeadingSpace to pass

  @citation @locator @citation-items
  Scenario: With Leading Space
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
          <group delimiter=":">
            <text variable="title" />
            <choose>
              <if locator="page"/>
              <else>
                 <label variable="locator"/>
              </else>
            </choose>
            <text variable="locator"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Hello Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":" 666"}]]
    """
    Then the results should be:
      | Hello Title:666 |
