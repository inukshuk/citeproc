Feature: position
  As a CSL cite processor hacker
  I want the test position_ResetNoteNumbers to pass

  @citation @position @citations
  Scenario: Reset Note Numbers
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
          <choose>
            <if position="ibid">
              <text value="ibid"/>
            </if>
            <else>
              <group delimiter=", ">
                <text variable="title"/>
                <group delimiter=" ">
                  <text value="n"/>
                  <text variable="first-reference-note-number"/>
                </group>
              </group>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"},{"id":"ITEM-2","title":"Book B","type":"book"},{"id":"ITEM-3","title":"Book C","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Book A (note 1)
    ..[1] ibid (note 2)
    ..[2] Book C (note 3)
    ..[3] Book C (note 1)
    ..[4] Book A (note 2)
    ..[5] ibid (note 3)
    ..[6] Book C, n 1 (note 4)
    >>[7] Book A, n 2 (note 5)
    """
