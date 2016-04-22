Feature: sort
  As a CSL cite processor hacker
  I want the test sort_LeadingApostropheOnNameParticle to pass

  @bibliography @sort @citations
  Scenario: Leading Apostrophe On Name Particle
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
      <macro name="author">
        <names variable="author">
          <name initialize-with=" " initialize="true" name-as-sort-order="all"/>
        </names>
      </macro>
      <citation>
        <layout>
          <text value="BOGUS"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author" />
        </sort>
        <layout>
          <text macro="author" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Horvath","given":"Peter A.A. 't"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Horvath","given":"Peter A.B. in 't"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"'t Horvath","given":"Peter A.C."}],"id":"ITEM-3","type":"book"},{"author":[{"family":"in 't Horvath","given":"Peter A.D."}],"id":"ITEM-4","type":"book"},{"author":[{"family":"Frinkle","given":"Bevis"}],"id":"ITEM-5","type":"book"},{"author":[{"family":"Klabdaggit","given":"Mizo"}],"id":"ITEM-6","type":"book"},{"author":[{"family":"Vooz","given":"Bablican"}],"id":"ITEM-7","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Frinkle, B</div>
      <div class="csl-entry">Horvath, P A B in ’t</div>
      <div class="csl-entry">Horvath, P A A ’t</div>
      <div class="csl-entry">In ’t Horvath, P A D</div>
      <div class="csl-entry">Klabdaggit, M</div>
      <div class="csl-entry">’t Horvath, P A C</div>
      <div class="csl-entry">Vooz, B</div>
    </div>
    """
