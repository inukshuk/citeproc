Feature: sort
  As a CSL cite processor hacker
  I want the test sort_NameParticleInNameSortTrue to pass

  @bibliography @sort
  Scenario: Name Particle In Name Sort True
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          demote-non-dropping-particle="never">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
            <text value="Ignore me"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author"/>
        </sort>
        <layout>
          <names variable="author">
            <name/>
          </names>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Roe","given":"Jane","non-dropping-particle":"van","static-ordering":false}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Noakes","given":"John","non-dropping-particle":"di","static-ordering":false}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Doe","given":"John","non-dropping-particle":"von","static-ordering":false}],"id":"ITEM-3","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">John di Noakes</div>
      <div class="csl-entry">Jane van Roe</div>
      <div class="csl-entry">John von Doe</div>
    </div>
    """
