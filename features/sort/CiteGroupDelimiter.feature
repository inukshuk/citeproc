Feature: sort
  As a CSL cite processor hacker
  I want the test sort_CiteGroupDelimiter to pass

  @citation @sort @citation-items
  Scenario: Cite Group Delimiter
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
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
      <citation cite-group-delimiter=", ">
        <sort>
          <key variable="issued" />
        </sort>
        <layout delimiter="; ">
          <group delimiter=" ">
            <text macro="author" />
            <date form="text" variable="issued" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","issued":{"date-parts":[[2001]]},"type":"book"},{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-2","issued":{"date-parts":[[2000]]},"type":"book"},{"author":[{"family":"Banda","given":"Gino"}],"id":"ITEM-3","issued":{"date-parts":[[1999]]},"type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-3"},{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Banda 1999; Aalto 2000, Aalto 2001 |
