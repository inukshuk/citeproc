Feature: sort
  As a CSL cite processor hacker
  I want the test sort_FamilyOnly to pass

  @bibliography @sort @non-standard
  Scenario: Family Only
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
      <citation>
        <layout>
          <text value="BOGUS"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author"/>
        </sort>
        <names variable="author">
          <name/>
        </names>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"ANZ Group"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Aardvaark"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Edelweis"}],"id":"ITEM-3","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Aardvaark</div>
      <div class="csl-entry">ANZ Group</div>
      <div class="csl-entry">Edelweis</div>
    </div>
    """
