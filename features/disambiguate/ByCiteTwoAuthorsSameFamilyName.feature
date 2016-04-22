Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ByCiteTwoAuthorsSameFamilyName to pass

  @citation @disambiguate
  Scenario: By Cite Two Authors Same Family Name
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
             disambiguate-add-year-suffix="true"
             givenname-disambiguation-rule="by-cite">
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
    [{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Asthma","given":"Bridget","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1980"]]},"title":"Book A","type":"book"},{"author":[{"family":"Bronchitis","given":"Beauregarde","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1995"]]},"title":"Book B","type":"book"},{"author":[{"family":"Asthma","given":"Albert","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[["1885"]]},"title":"Book C","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Asthma and Asthma (1980); Bronchitis (1995); Asthma (1885)
    """
