Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_PrimaryNameGenerally to pass

  @citation @disambiguate
  Scenario: Primary Name Generally
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
             disambiguate-add-givenname="true"
             givenname-disambiguation-rule="primary-name">
        <layout delimiter="; ">
          <names delimiter=", " variable="author">
            <name and="text" delimiter-precedes-last="never" form="short" />
          </names>
          <group prefix=" (" suffix=")">
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Asthma","given":"Aloysius","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1980"]]},"type":"book"},{"author":[{"family":"Asthma","given":"Artemis","static-ordering":false},{"family":"Bronchitis","given":"Beauregarde","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1995"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Aloysius Asthma and Bronchitis (1980); Artemis Asthma and Bronchitis (1995)
    """
