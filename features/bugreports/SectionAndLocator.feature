Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_SectionAndLocator to pass

  @citation @bugreports @citation-items
  Scenario: Section And Locator
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
            <text variable="locator"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","section":"456","title":"Title One","type":"legislation"},{"id":"ITEM-2","section":"456","title":"Title Two","type":"legislation"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"123"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Title One, 123 |
      | Title Two |
