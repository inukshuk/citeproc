Feature: integration
  As a CSL cite processor hacker
  I want the test integration_DisambiguateAddGivenname2 to pass

  @citation @integration @citations
  Scenario: Disambiguate Add Givenname2
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
             disambiguate-add-names="true"
             disambiguate-add-givenname="true">
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
    [{"author":[{"family":"Smith","given":"John"},{"family":"Smith","given":"Jane"}],"id":"ITEM-1","issued":{"date-parts":[[1980]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[[1986]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Smith &amp; Smith (1980)
    """
