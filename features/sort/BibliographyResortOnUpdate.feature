Feature: sort
  As a CSL cite processor hacker
  I want the test sort_BibliographyResortOnUpdate to pass

  @bibliography @sort @citation-items
  Scenario: Bibliography Resort On Update
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
          <name form="short" />
        </names>
      </macro>
      <citation>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="author" />
        </sort>
        <layout>
          <text macro="author" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Effinger","given":"Eda"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Jamey","given":"Jantzen"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Ging","given":"Tina"}],"id":"ITEM-3","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Effinger</div>
      <div class="csl-entry">Ging</div>
      <div class="csl-entry">Jamey</div>
    </div>
    """
