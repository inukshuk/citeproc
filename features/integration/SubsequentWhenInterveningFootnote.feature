Feature: integration
  As a CSL cite processor hacker
  I want the test integration_SubsequentWhenInterveningFootnote to pass

  @citation @integration @citations
  Scenario: Subsequent When Intervening Footnote
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
        <layout delimiter="; " prefix="(" suffix=")">
          <choose>
            <if position="first">
              <names variable="author">
                <name form="short"/>
              </names>
              <group prefix=" ">
                <label variable="locator" form="short" suffix=" "/>
                <text variable="locator"/>
              </group>
            </if>
            <else-if position="subsequent">
     		    <text value="I am subsequent"/>
    		</else-if>
            <else>
                <text value="I am ibid or ibid-with-locator"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] (Doe)
    >>[1] (I am subsequent)
    """
