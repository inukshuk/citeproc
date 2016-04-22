Feature: name
  As a CSL cite processor hacker
  I want the test name_SubsequentAuthorSubstituteMultipleNames to pass

  @bibliography @name @citations
  Scenario: Subsequent Author Substitute Multiple Names
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
        <layout>
          <text value="Bogus"/>
        </layout>
      </citation>
      <bibliography subsequent-author-substitute="-----">
        <layout>
          <group delimiter=", ">
            <names variable="author">
              <name form="short" and="text"/>
            </names>
            <text variable="title"/>
            <names variable="translator">
              <name form="short" and="text"/>
              <label form="short" prefix=" "/>
            </names>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Bumke","given":"Joachim"}],"id":"ITEM-1","title":"Courtly Culture: Literature and Society in the High Middle Ages","translator":[{"family":"Dunlap","given":"Thomas"}],"type":"book"},{"author":[{"family":"Bumke","given":"Joachim"}],"id":"ITEM-2","title":"Höfische","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Bumke, Courtly Culture: Literature and Society in the High Middle Ages, Dunlap tran.</div>
      <div class="csl-entry">-----, Höfische</div>
    </div>
    """
