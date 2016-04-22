Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ExtraTextCitation to pass

  @citation @disambiguate @citations
  Scenario: Extra Text Citation
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
      <citation disambiguate-add-givenname="true">
        <layout>
          <group delimiter=", ">
            <names variable="author">
              <name form="short" and="text"/>
            </names>
            <choose>
              <if disambiguate="true">
                <text variable="title"/>
              </if>
            </choose>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Bumke","given":"Joachim"}],"id":"ITEM-1","title":"Courtly Culture: Literature and Society in the High Middle Ages","translator":[{"family":"Dunlap","given":"Thomas"}],"type":"book"},{"author":[{"family":"Bumke","given":"Joachim"}],"id":"ITEM-2","title":"Höfische","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Bumke, Courtly Culture: Literature and Society in the High Middle Ages
    >>[1] Bumke, Höfische
    """
