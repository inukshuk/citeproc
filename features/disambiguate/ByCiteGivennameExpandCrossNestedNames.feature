Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ByCiteGivennameExpandCrossNestedNames to pass

  @citation @disambiguate
  Scenario: By Cite Givenname Expand Cross Nested Names
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
             et-al-min="3"
             et-al-use-first="1"
             givenname-disambiguation-rule="by-cite">
        <layout delimiter="; ">
          <names delimiter=", " variable="author">
            <name delimiter=", " initialize-with="." />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ambigs-12","issued":{"date-parts":[["1990"]]},"title":"Book C","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Josephine","static-ordering":false},{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ambigs-13","issued":{"date-parts":[["1990"]]},"title":"Book B","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Jones","given":"Richard","static-ordering":false}],"id":"ambigs-14","issued":{"date-parts":[["1990"]]},"title":"Book A","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    J. Doe, Jane Roe, Robert Jones; J. Doe, Josephine Roe, et al.; J. Doe, Jane Roe, Richard Jones
    """
