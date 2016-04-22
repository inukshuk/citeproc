Feature: locator
  As a CSL cite processor hacker
  I want the test locator_TermSelection to pass

  @citation @locator @citations
  Scenario: Term Selection
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
            <text variable="title" />
            <group delimiter=" ">
              <label variable="locator" form="short"/>
              <text variable="locator"/>
            </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Book A, f. 101
    """
