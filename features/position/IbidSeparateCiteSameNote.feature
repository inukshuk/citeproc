Feature: position
  As a CSL cite processor hacker
  I want the test position_IbidSeparateCiteSameNote to pass

  @citation @position @citations
  Scenario: Ibid Separate Cite Same Note
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout suffix="." delimiter="; ">
          <choose>
            <if position="ibid-with-locator">
              <group delimiter=" ">
                <text term="ibid" />
                <group delimiter=" ">
                  <label variable="locator"/>
                  <text variable="locator"/>
                </group>
              </group>
            </if>
            <else-if position="ibid">
              <text term="ibid" />
            </else-if>
            <else-if position="subsequent">
              <group delimiter=" ">
                <names variable="author">
                  <name form="short" />
                </names>
                <text value="supra"/>
                <group delimiter=" ">
                  <text value="note"/>
                  <text variable="first-reference-note-number"/>
                </group>
                <group delimiter=" ">
                  <label variable="locator"/>
                  <text variable="locator"/>
                </group>
              </group>
            </else-if>
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
    ..[0] [citation1-item1-note1] Appleton “Tom Swift and His Electric Runabout” (1910).
    ..[1] [citation2-item1-note2] ibid.
    ..[2] [citation3-item1-note2] ibid. page 33.
    ..[3] [citation4-item2-note3] Bloggs “A Very Short Book Indeed” (2012); [citation4-item1-note3] Appleton supra note 1.
    ..[4] [citation5-item1-note4] Appleton supra note 1 page 99.
    ..[5] [citation6-item1-note4] Appleton supra note 1.
    >>[6] [citation7-item1-note4] ibid.
    """
