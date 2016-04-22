Feature: position
  As a CSL cite processor hacker
  I want the test position_IbidInText to pass

  @citation @position @citations
  Scenario: Ibid In Text
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
            <if position="ibid">
              <text term="ibid" />
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
    [{"author":[{"family":"Appleton","given":"Victor","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1910"]]},"title":"Tom Swift and His Electric Runabout","type":"book"},{"author":[{"family":"Bloggs","given":"Joe"}],"id":"ITEM-2","issued":{"date-parts":[["2012"]]},"title":"A Very Short Book Indeed","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Appleton “Tom Swift and His Electric Runabout” (1910).
    ..[1] Bloggs “A Very Short Book Indeed” (2012).
    >>[2] Ibid.
    """
