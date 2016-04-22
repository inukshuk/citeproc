Feature: name
  As a CSL cite processor hacker
  I want the test name_ParticleCaps2 to pass

  @bibliography @name @citations @non-standard
  Scenario: Particle Caps2
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
      <citation>
        <layout>
          <text value="Bogus"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group>
            <names variable="author" delimiter="; ">
              <name name-as-sort-order="all" delimiter=", " initialize-with="."/>
            </names>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"van One","given":"Onename"},{"family":"van Two","given":"Twoname"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"van Three","given":"Threename"},{"family":"Van Four","given":"Fourname"}],"id":"ITEM-2","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Van One, O., van Two, T.</div>
      <div class="csl-entry">Van Three, T., Van Four, F.</div>
    </div>
    """
