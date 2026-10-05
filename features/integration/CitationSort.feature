Feature: integration
  As a CSL cite processor hacker
  I want the test integration_CitationSort to pass

  @citation @integration @citation-items
  Scenario: Citation Sort
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
        <sort>
          <key variable="author"/>
        </sort>
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
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Roe","given":"Jane"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Noakes","given":"John"}],"id":"ITEM-3","type":"book"},{"author":[{"family":"Snoakes","given":"Richard"}],"id":"ITEM-4","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-3"},{"id":"ITEM-4"},{"id":"ITEM-1"},{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | (Doe; Noakes; Roe; Snoakes) |
