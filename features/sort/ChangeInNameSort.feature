Feature: sort
  As a CSL cite processor hacker
  I want the test sort_ChangeInNameSort to pass

  @bibliography @sort @citations
  Scenario: Change In Name Sort
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          demote-non-dropping-particle="display-and-sort">
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
        <sort>
          <key macro="author" />
        </sort>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author"/>
        </sort>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"De Quincey","given":"Alan"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Noakes","given":"Ajax"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Carter","given":"Cedric"}],"id":"ITEM-3","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Carter</div>
      <div class="csl-entry">Noakes</div>
      <div class="csl-entry">De Quincey</div>
    </div>
    """
