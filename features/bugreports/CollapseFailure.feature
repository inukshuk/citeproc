Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_CollapseFailure to pass

  @citation @bugreports
  Scenario: Collapse Failure
    Given the following style:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <style xmlns="http://purl.org/net/xbiblio/csl" version="1.0"
    class="in-text">
      <info>
        <title>My First Style</title>
        <id>my-first-style</id>
        <updated>2008-10-29T21:01:24+00:00</updated>
      </info>
      <macro name="author-short">
        <names variable="author">
          <name form="short"/>
        </names>
      </macro>
      <macro name="author">
        <names variable="author">
          <name name-as-sort-order="all" initialize-with=". "/>
        </names>
      </macro>
      <macro name="issued">
        <date variable="issued">
          <date-part name="year"/>
        </date>
      </macro>
      <citation et-al-min="3" et-al-use-first="1" disambiguate-add-year-suffix="true" collapse="year">
        <sort>
          <key macro="issued"/>
          <key macro="author-short"/>
        </sort>
        <layout prefix="(" suffix=")" delimiter="; ">
          <group delimiter=" ">
            <text macro="author-short"/>
            <text macro="issued"/>
          </group>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="author"/>
          <key macro="issued"/>
        </sort>
        <layout suffix=".">
          <group delimiter=" ">
            <text macro="author"/>
            <text macro="issued" prefix="(" suffix=")"/>
            <text variable="title" suffix="."/>
            <text variable="container-title" font-style="italic"/>
          </group>
          <group prefix=", ">
            <text variable="volume" suffix=":"/>
            <text variable="page"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"},{"family":"Noakes","given":"Richard"}],"id":"ITEM-1","issued":{"date-parts":[["1965"]]},"type":"book"},{"author":[{"family":"Doe","given":"John"},{"family":"Spindlethrift","given":"Melanie"},{"family":"Korkblougher","given":"Weegas"}],"id":"ITEM-2","issued":{"date-parts":[["1965"]]},"type":"book"},{"author":[{"family":"Doe","given":"John"},{"family":"Blub","given":"Sophie"},{"family":"Lanbright","given":"Bugeyes"}],"id":"ITEM-3","issued":{"date-parts":[["1970"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (Doe et al. 1965a, 1965b, 1970)
    """
