Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_AllNamesBaseNameCountOnFailureIfYearSuffixAvailable to pass

  @citation @disambiguate
  Scenario: All Names Base Name Count On Failure If Year Suffix Available
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
             disambiguate-add-names="true"
             disambiguate-add-year-suffix="true"
             et-al-min="3"
             et-al-use-first="1"
             givenname-disambiguation-rule="all-names">
        <layout delimiter="; ">
          <names delimiter=", " variable="author">
            <name delimiter=", " form="short" initialize-with="." />
          </names>
          <group prefix=" (" suffix=")">
            <date variable="issued">
              <date-part name="year" />
            </date>
            <text variable="year-suffix" />
          </group>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author" names-min="2" names-use-first="1"/>
        </sort>
        <layout>
          <text value="bogus"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["1990"]]},"title":"Book A","type":"book"},{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1990"]]},"title":"Book B","type":"book"},{"author":[{"family":"Dropsy","given":"Devon","static-ordering":false},{"family":"Enteritis","given":"Edward","static-ordering":false},{"family":"Fever","given":"Xavier","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[["2000"]]},"title":"Book C","type":"book"},{"author":[{"family":"Dropsy","given":"Devon","static-ordering":false},{"family":"Enteritis","given":"Ernie","static-ordering":false},{"family":"Fever","given":"Yves","static-ordering":false}],"id":"ITEM-4","issued":{"date-parts":[["2000"]]},"title":"Book D","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Asthma et al. (1990a); Asthma et al. (1990b); Dropsy, Edward Enteritis, et al. (2000); Dropsy, Ernie Enteritis, et al. (2000)
    """
