Feature: decorations
  As a CSL cite processor hacker
  I want the test decorations_Baseline to pass

  @bibliography @decorations
  Scenario: Baseline
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
          <text value="Ignore me"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=" " vertical-align="sup">
            <group delimiter=", ">
              <names variable="author">
                <name sort-separator=", " name-as-sort-order="all"/>
              </names>
              <text vertical-align="baseline" variable="title"/>
            </group>
            <date variable="issued" form="text" prefix="(" suffix=")"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Little","given":"Stuart"}],"id":"ITEM-1","issued":{"date-parts":[["1990"]]},"title":"My Short Narrative","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry"><sup>Little, Stuart, <span style="baseline">My Short Narrative</span> (1990)</sup></div>
    </div>
    """
