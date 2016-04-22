Feature: magic
  As a CSL cite processor hacker
  I want the test magic_StripPeriodsTrueShortForm to pass

  @citation @magic
  Scenario: Strip Periods True Short Form
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
      <macro name="author-biblio">
        <names variable="author">
          <name />
        </names>
      </macro>
      <citation>
        <layout suffix="." delimiter="; ">
          <text strip-periods="true" variable="container-title" form="short" />
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author" />
        </sort>
        <layout>
          <text macro="author-biblio" suffix=". " />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"container-title":"American Law Journal","id":"ITEM-1","journalAbbreviation":"Am. L.J.","title":"An Article","type":"article-journal"},{"container-title":"Am. L.J.","id":"ITEM-2","title":"Another Article","type":"article-journal"}]
    """
    When I cite all items
    Then the result should be:
    """
    Am LJ; Am LJ.
    """
