Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_DisambiguateWithThree to pass

  @citation @disambiguate @citations
  Scenario: Disambiguate With Three
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
      <macro name="author">
        <names variable="author">
          <name form="short" />
        </names>
      </macro>
      <citation et-al-min="4" et-al-use-first="1" disambiguate-add-names="true" disambiguate-add-givenname="true">
        <layout prefix="(" suffix=")">
          <group delimiter=", ">
            <text macro="author" />
            <choose>
              <if disambiguate="true">
                <text variable="title" font-style="italic"/>
              </if>
            </choose>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","title":"Book A","type":"book"},{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-2","title":"Book B","type":"book"},{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-3","title":"Book C","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] (Aalto, <i>Book A</i>)
    >>[1] (Aalto, <i>Book B</i>)
    >>[2] (Aalto, <i>Book C</i>)
    """
