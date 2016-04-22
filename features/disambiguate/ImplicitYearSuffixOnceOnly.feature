Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ImplicitYearSuffixOnceOnly to pass

  @bibliography @disambiguate
  Scenario: Implicit Year Suffix Once Only
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
      <citation 
             disambiguate-add-year-suffix="true">
        <layout delimiter="; " prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name form="short"/>
            </names>
            <date variable="issued" date-parts="year" form="text"/>
          </group>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=" ">
            <date date-parts="year" form="text" variable="issued" prefix="[" suffix="]"/>
            <group delimiter=", ">
              <names variable="author">
                <name form="short"/>
              </names>
              <text variable="title"/>
            </group>
            <date form="numeric" variable="issued"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1990","5","30"]]},"title":"Book A","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1990","5","30"]]},"title":"Book B","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">[1990a] Doe, Book A 05/30/1990</div>
      <div class="csl-entry">[1990b] Doe, Book B 05/30/1990</div>
    </div>
    """
