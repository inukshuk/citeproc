Feature: number
  As a CSL cite processor hacker
  I want the test number_PreserveDelimiter to pass

  @citation @number @citation-items
  Scenario: Preserve Delimiter
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
      <macro name="container-contributors">
        <choose>
          <if type="chapter paper-conference" match="any">
            <text term="in" suffix=" " font-style="italic"/>
            <names variable="editor translator" delimiter=", ">
              <name and="text" initialize-with=". " delimiter=", "/>
              <label form="long" prefix=", " suffix="."/>
            </names>
          </if>
        </choose>
      </macro>
      <macro name="secondary-contributors">
        <choose>
          <if type="chapter paper-conference" match="none">
            <names variable="editor translator" delimiter=", ">
              <name and="text" initialize-with=". " delimiter=", "/>
              <label prefix=", "/>
            </names>
          </if>
        </choose>
      </macro>
      <citation>
        <layout>
          <group prefix=". " delimiter=" ">
            <label variable="page" form="long" text-case="capitalize-first"/>
            <text variable="page"/>
            <text macro="container-contributors"/>
            <text variable="container-title"/>
            <text macro="secondary-contributors"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"Analysis and interpretation of freshwater fisheries data","editor":[{"family":"Stephen","given":"Clarence Stephen"},{"family":"Brown","given":"Michael Lawrence"}],"id":"ITEM-1","page":"187-228","type":"chapter"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | . Pages 187–228 <i>in</i> C. S. Stephen and M. L. Brown, editors. Analysis and interpretation of freshwater fisheries data |
