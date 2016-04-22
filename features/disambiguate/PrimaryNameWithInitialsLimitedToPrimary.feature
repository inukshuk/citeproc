Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_PrimaryNameWithInitialsLimitedToPrimary to pass

  @citation @disambiguate
  Scenario: Primary Name With Initials Limited To Primary
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
             et-al-min="3"
             et-al-use-first="1"
             disambiguate-add-givenname="true"
             disambiguate-add-year-suffix="true"
             givenname-disambiguation-rule="primary-name-with-initials">
        <layout delimiter="; ">
          <names delimiter=", " variable="author">
            <name and="text" delimiter=", " delimiter-precedes-last="never" form="short" initialize-with="." />
          </names>
          <group prefix=" (" suffix=")">
            <date variable="issued">
              <date-part name="year" />
            </date>
            <text variable="year-suffix" />
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1980"]]},"title":"Book A","type":"book"},{"author":[{"family":"Asthma","given":"Gargoyle","static-ordering":false},{"family":"Bronchitis","given":"Billy","static-ordering":false},{"family":"Cold","given":"Odeous","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1995"]]},"title":"Book B","type":"book"},{"author":[{"family":"Dropsy","given":"Duncan","static-ordering":false},{"family":"Asthma","given":"Albert","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[["1995"]]},"title":"Book B","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    A. Asthma et al. (1980); G. Asthma et al. (1995); Dropsy and Asthma (1995)
    """
