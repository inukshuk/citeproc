Feature: position
  As a CSL cite processor hacker
  I want the test position_IbidWithLocator to pass

  @citation @position @citation-items
  Scenario: Ibid With Locator
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
        <layout suffix=".">
          <choose>
            <if position="ibid-with-locator">
              <text term="ibid" />
              <label form="short" prefix=" " strip-periods="false" variable="locator" />
              <text prefix=" " variable="locator" />
            </if>
            <else>
              <group delimiter=" ">
                <names variable="author">
                  <name form="short" />
                </names>
                <text quotes="true" variable="title" />
                <date prefix="(" suffix=")" variable="issued">
                  <date-part name="year" />
                </date>
              </group>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Appleton","given":"Victor","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1910"]]},"title":"Tom Swift and His Electric Runabout","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-1","label":"page","locator":"23","position":4}]]
    """
    Then the results should be:
      | Appleton “Tom Swift and His Electric Runabout” (1910). |
      | Ibid. p. 23. |
