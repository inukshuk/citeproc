Feature: integration
  As a CSL cite processor hacker
  I want the test integration_IbidWithDifferentLocators to pass

  @citation @integration @citations
  Scenario: Ibid With Different Locators
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
            <else-if position="ibid-with-locator">
              <text value="ibid-with-locator"/>
            </else-if>
            <else-if position="ibid">
              <text term="ibid"/>
            </else-if>
            <else-if position="subsequent">
              <text value="subsequent"/>
            </else-if>
            <else>
              <text value="huh?"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Noakes","given":"John","static-ordering":false}],"id":"ITEM-3","type":"book"},{"author":[{"family":"Snoakes","given":"Richard","static-ordering":false}],"id":"ITEM-4","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] (Doe p. 12)
    ..[1] (ibid-with-locator)
    ..[2] (Roe bk. 20)
    >>[3] (ibid-with-locator)
    """
