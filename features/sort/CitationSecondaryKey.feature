Feature: sort
  As a CSL cite processor hacker
  I want the test sort_CitationSecondaryKey to pass

  @citation @sort @citations
  Scenario: Citation Secondary Key
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
          <name form="short"/>
        </names>
      </macro>
      <citation>
        <sort>
          <key variable="issued" sort="ascending"/>
          <key macro="author" sort="ascending"/>
        </sort>
        <layout delimiter="; ">
          <group delimiter=" ">
            <text macro="author" />
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Roe","given":"Jane"}],"id":"ITEM-1","issued":{"date-parts":[[1995]]},"type":"book"},{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[[1995]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Doe 1995; Roe 1995
    """
