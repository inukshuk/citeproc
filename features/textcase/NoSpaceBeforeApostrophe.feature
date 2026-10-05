Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_NoSpaceBeforeApostrophe to pass

  @citation @textcase @citation-items
  Scenario: No Space Before Apostrophe
    Given the following style:
    """
    <?xml version="1.0" encoding="utf-8"?>
    <style xmlns="http://purl.org/net/xbiblio/csl" class="note" version="1.0" demote-non-dropping-particle="never">
      <info>
        <title>Chicago Manual of Style (full note, no Ibid.)</title>
        <id>http://www.zotero.org/styles/chicago-fullnote-bibliography-no-ibid</id>
        <link href="http://www.zotero.org/styles/chicago-fullnote-bibliography-no-ibid" rel="self"/>
        <link href="http://www.chicagomanualofstyle.org/tools_citationguide.html" rel="documentation"/>
        <author>
          <name>anon</name>
        </author>
        <category citation-format="note"/>
        <category field="generic-base"/>
        <summary>Chicago format with full notes and bibliography</summary>
        <updated>2012-10-25T21:15:26+00:00</updated>
        <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
      </info>
      <citation>
        <layout>
          <group delimiter=", ">
            <names variable="editor">
              <name/>
              <label prefix=" (" suffix=")" form="short"/>
            </names>
            <text variable="title" text-case="title"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"family":"Shafi'i","given":"Marcus"}],"id":"ITEM-1","title":"Response to Shafi'i comment","type":"book"},{"editor":[{"family":"Shafi`i","given":"Marcus"}],"id":"ITEM-2","title":"Response to Shafi`i comment","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Marcus Shafi’i (ed.), Response to Shafi’i Comment  |
      | Marcus Shafi`i (ed.), Response to Shafi`i Comment  |
