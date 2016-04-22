Feature: position
  As a CSL cite processor hacker
  I want the test position_IbidWithSuffix to pass

  @bibliography @position @citations
  Scenario: Ibid With Suffix
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          demote-non-dropping-particle="sort-only">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <macro name="author">
        <names variable="author">
          <name/>
        </names>
      </macro>
      <citation>
        <layout>
          <text value="Bogus"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
           <key macro="author"/>
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
    [{"author":[{"family":"Al-Khatib Organization"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Aberdeen","given":"Alan"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Butterfield","given":"Beatrice"}],"id":"ITEM-3","type":"book"},{"author":[{"family":"Kaspersky","given":"Sergei"}],"id":"ITEM-4","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Alan Aberdeen</div>
      <div class="csl-entry">Al-Khatib Organization</div>
      <div class="csl-entry">Beatrice Butterfield</div>
      <div class="csl-entry">Sergei Kaspersky</div>
    </div>
    """
