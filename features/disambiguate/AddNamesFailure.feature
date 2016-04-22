Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_AddNamesFailure to pass

  @citation @disambiguate
  Scenario: Add Names Failure
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
             disambiguate-add-names="true">
        <layout delimiter="; ">
          <group delimiter=" ">
            <names delimiter=", " variable="author">
              <name and="symbol" delimiter-precedes-last="never" form="short"/>
            </names>
            <date variable="issued" prefix="(" suffix=")">
              <date-part name="year"/>
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John","static-ordering":false},{"family":"Brown","given":"John","static-ordering":false},{"family":"Jones","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[[1980]]},"type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false},{"family":"Brown","given":"John","static-ordering":false},{"family":"Jones","given":"John","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[[1980]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Smith et al. (1980); Smith et al. (1980)
    """
