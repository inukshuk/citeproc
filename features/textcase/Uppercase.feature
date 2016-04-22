Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_Uppercase to pass

  @citation @textcase @non-standard
  Scenario: Uppercase
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
      <macro name="title-or-title-and-translator">
        <choose>
          <if type="webpage">
            <text macro="title"/>
          </if>
          <else>
            <text macro="title" suffix=", "/>
            <names variable="translator">
              <name/>
            </names>
          </else>
        </choose>
      </macro>
      <macro name="title">
        <text variable="title"/>
      </macro>
      <citation>
        <layout>
          <group delimiter=": ">
            <names variable="author">
              <name name-as-sort-order="all">
                <name-part name="family" text-case="uppercase"/>
              </name>
              <substitute>
                <text macro="title-or-title-and-translator"/>
              </substitute>
            </names>
            <text variable="title" text-case="uppercase"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","title":"This is a pen that is a <span class=\"nocase\">Smith</span> pencil","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    SMITH, John: THIS IS A PEN THAT IS A SMITH PENCIL
    """
