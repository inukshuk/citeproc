Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_NumericField to pass

  @citation @flipflop
  Scenario: Numeric Field
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
        <contributor>
          <name>Frank Bennett</name>
          <email>biercenator@gmail.com</email>
        </contributor>
        <category citation-format="note"/>
        <category field="generic-base"/>
        <summary>Chicago format with full notes and bibliography</summary>
        <updated>2012-10-25T21:15:26+00:00</updated>
        <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
      </info>
      <citation>
        <layout>
          <number variable="number"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","number":"1<sup>er</sup>","type":""}]
    """
    When I cite all items
    Then the result should be:
    """
    1&#60;sup&#62;er&#60;/sup&#62;
    """
