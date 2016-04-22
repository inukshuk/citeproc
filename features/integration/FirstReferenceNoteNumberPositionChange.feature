Feature: integration
  As a CSL cite processor hacker
  I want the test integration_FirstReferenceNoteNumberPositionChange to pass

  @citation @integration @citations
  Scenario: First Reference Note Number Position Change
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
            <if position="first">
              <group delimiter=" ">
                <group delimiter=", ">
                  <names variable="author">
                    <name form="short"/>
                  </names>
                  <text variable="title" quotes="true"/>
                </group>
                <date variable="issued" date-parts="year" form="text" prefix="(" suffix=")"/>
              </group>
            </if>
            <else-if position="subsequent">
              <group delimiter=", ">
                <names variable="author">
                  <name form="short"/>
                </names>
                <text value="supra"/>
              </group>
              <text variable="first-reference-note-number" prefix=" note "/>
            </else-if>
            <else>
              <text term="ibid"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[[1901]]},"title":"Life of Doe","type":"book"},{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[[1900]]},"title":"Life of Roe","type":"book"},{"author":[{"family":"Snoakes","given":"Richard","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[[1902]]},"title":"Life of Snoakes","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Snoakes, “Life of Snoakes” (1902).
    ..[1] Doe, “Life of Doe” (1901).
    ..[2] Roe, “Life of Roe” (1900).
    >>[3] Doe, supra note 2.
    >>[4] Roe, supra note 3.
    """
