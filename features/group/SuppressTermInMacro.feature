Feature: group
  As a CSL cite processor hacker
  I want the test group_SuppressTermInMacro to pass

  @citation @group @citation-items
  Scenario: Suppress Term In Macro
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <title>Chicago Manual of Style (Full Note with Bibliography)</title>
        <id>http://www.zotero.org/styles/chicago-fullnote-bibliography</id>
        <link rel="self" href="http://www.zotero.org/styles/chicago-fullnote-bibliography" />
        <link href="http://www.chicagomanualofstyle.org/tools_citationguide.html" rel="documentation" />
        <author>
          <name>Julian Onions</name>
          <email>julian.onions@gmail.com</email>
        </author>
        <contributor>
          <name>Simon Kornblith</name>
          <email>simon@simonster.com</email>
        </contributor>
        <contributor>
          <name>Elena Razlogova</name>
          <email>elena.razlogova@gmail.com</email>
        </contributor>
        <summary>Chicago format with full notes and bibliography</summary>
        <category field="generic-base" />
        <category citation-format="numeric" />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <macro name="container-title-note">
        <choose>
          <if type="chapter">
            <text suffix=" " term="in" text-case="lowercase"/>
          </if>
        </choose>
        <text font-style="italic" variable="container-title" />
      </macro>
      <citation>
        <layout>
          <group delimiter=", ">
            <text variable="title"/>
            <text macro="container-title-note" />
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"chapter"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | His Anonymous Life |
