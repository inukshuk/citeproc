Feature: sort
  As a CSL cite processor hacker
  I want the test sort_LatinUnicode to pass

  @citation @sort @citation-items
  Scenario: Latin Unicode
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <title>Test fixture</title>
        <id>http://citationstyles.org/tests/fixture</id>
        <link href="http://citationstyles.org/tests/fixture" rel="self"/>
        <link href="http://citationstyles.org/documentation/text" rel="documentation"/>
        <category citation-format="author-date"/>
        <updated>2014-04-30T13:19:38+00:00</updated>
        <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
      </info>
      <macro name="author">
        <names variable="author">
          <name form="short" />
        </names>
      </macro>
      <citation>
        <sort>
          <key macro="author" />
        </sort>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Álvarez","given":"Ajax"}],"id":"ITEM-2","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Aalto; Álvarez |
