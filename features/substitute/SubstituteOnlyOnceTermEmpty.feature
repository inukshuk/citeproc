Feature: substitute
  As a CSL cite processor hacker
  I want the test substitute_SubstituteOnlyOnceTermEmpty to pass

  @citation @substitute
  Scenario: Substitute Only Once Term Empty
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2019-08-11T16:56:00+02:00</updated>
      </info>
      <locale>
        <terms>
          <term name="author">Author Term Value</term>
          <term name="editor"></term>
        </terms>
      </locale>
      <citation>
        <layout>
          <group delimiter=" ">
            <group><text value="Content:"/></group>
            <names variable="translator">
              <substitute>
                <text term="editor"/>
                <text term="author"/>
              </substitute>
            </names>
          </group>
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
    Content:
    """
