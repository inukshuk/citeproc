Feature: name
  As a CSL cite processor hacker
  I want the test name_HyphenatedNonDroppingParticle2 to pass

  @bibliography @name
  Scenario: Hyphenated Non Dropping Particle2
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          demote-non-dropping-particle="always">
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
        <layout delimiter="; ">
          <text value="Bogus"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="author" />
        </sort>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"al-One","given":"Alan"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Marple","given":"Mary"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Participle","given":"Paul"}],"id":"ITEM-3","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Mary Marple</div>
      <div class="csl-entry">Alan al-One</div>
      <div class="csl-entry">Paul Participle</div>
    </div>
    """
