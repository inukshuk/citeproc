Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_YearSuffixAndSort to pass

  @citation @disambiguate @citation-items
  Scenario: Year Suffix And Sort
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
      <macro name="date">
        <date variable="issued">
          <date-part name="year" />
        </date>
        <text suffix="!" variable="year-suffix" />
      </macro>
      <citation 
             disambiguate-add-year-suffix="true">
        <layout delimiter="; ">
          <text macro="date" />
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="issued" />
          <key variable="title" />
        </sort>
        <layout>
          <text value="Ignore me" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false},{"family":"Dropsy","given":"David","static-ordering":false},{"family":"Ebola","given":"Elvin","static-ordering":false},{"family":"Fever","given":"Fergus","static-ordering":false}],"id":"ambigs-1","issued":{"date-parts":[["1990"]]},"title":"Book M","type":"book"},{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false},{"family":"Dropsy","given":"David","static-ordering":false},{"family":"Enteritis","given":"Ernie","static-ordering":false},{"family":"Fever","given":"Fergus","static-ordering":false}],"id":"ambigs-2","issued":{"date-parts":[["1990"]]},"title":"Book L","type":"book"},{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false},{"family":"Dropsy","given":"David","static-ordering":false},{"family":"Ebola","given":"Elvin","static-ordering":false},{"family":"Fever","given":"Fergus","static-ordering":false}],"id":"ambigs-3","issued":{"date-parts":[["1990"]]},"title":"Book K","type":"book"},{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false}],"id":"ambigs-4","issued":{"date-parts":[["1990"]]},"title":"Book J","type":"book"},{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Beauregarde","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false}],"id":"ambigs-5","issued":{"date-parts":[["1990"]]},"title":"Book I","type":"book"},{"author":[{"family":"Asthma","given":"Alan","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false},{"family":"Dropsy","given":"David","static-ordering":false},{"family":"Ebola","given":"Elvin","static-ordering":false},{"family":"Fever","given":"Fergus","static-ordering":false}],"id":"ambigs-6","issued":{"date-parts":[["1990"]]},"title":"Book H","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Janet","static-ordering":false}],"id":"ambigs-7","issued":{"date-parts":[["1990"]]},"title":"Book G","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ambigs-8","issued":{"date-parts":[["1990"]]},"title":"Book F","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ambigs-9","issued":{"date-parts":[["1990"]]},"title":"Book E","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Janet","static-ordering":false}],"id":"ambigs-10","issued":{"date-parts":[["1990"]]},"title":"Book D","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ambigs-11","issued":{"date-parts":[["1990"]]},"title":"Book C","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Josephine","static-ordering":false},{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ambigs-12","issued":{"date-parts":[["1990"]]},"title":"Book B","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Jones","given":"Richard","static-ordering":false}],"id":"ambigs-13","issued":{"date-parts":[["1990"]]},"title":"Book A","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ambigs-1"},{"id":"ambigs-2"},{"id":"ambigs-3"},{"id":"ambigs-4"},{"id":"ambigs-5"},{"id":"ambigs-6"},{"id":"ambigs-7"},{"id":"ambigs-8"},{"id":"ambigs-9"},{"id":"ambigs-10"},{"id":"ambigs-11"},{"id":"ambigs-12"},{"id":"ambigs-13"}]]
    """
    Then the results should be:
      | 1990m!; 1990l!; 1990k!; 1990j!; 1990i!; 1990h!; 1990g!; 1990f!; 1990e!; 1990d!; 1990c!; 1990b!; 1990a! |
