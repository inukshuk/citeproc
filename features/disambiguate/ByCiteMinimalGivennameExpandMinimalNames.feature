Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ByCiteMinimalGivennameExpandMinimalNames to pass

  @citation @disambiguate
  Scenario: By Cite Minimal Givenname Expand Minimal Names
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
          <names variable="author">
            <name delimiter=", " initialize-with="." />
          </names>
        </layout>
      </citation>
      <bibliography>
        <sort>
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
    [{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Brandon","static-ordering":false},{"family":"Cold","given":"Charles","static-ordering":false}],"id":"ambigs-16","issued":{"date-parts":[["1990"]]},"title":"Book M","type":"book"},{"author":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Biff","static-ordering":false},{"family":"Cold","given":"Curtis","static-ordering":false}],"id":"ambigs-17","issued":{"date-parts":[["1990"]]},"title":"Book M","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    A. Asthma, Brandon Bronchitis, et al.; A. Asthma, Biff Bronchitis, et al.
    """
