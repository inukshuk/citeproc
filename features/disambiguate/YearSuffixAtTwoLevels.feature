Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_YearSuffixAtTwoLevels to pass

  @citation @disambiguate @citations
  Scenario: Year Suffix At Two Levels
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
             disambiguate-add-year-suffix="true">
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
    [{"author":[{"family":"Smith","given":"John"},{"family":"Jones","given":"John"},{"family":"Brown","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Jones","given":"John"},{"family":"Brown","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Jones","given":"John"},{"family":"Brown","given":"John"},{"family":"Green","given":"John"}],"id":"ITEM-3","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Jones","given":"John"},{"family":"Brown","given":"John"},{"family":"Green","given":"John"}],"id":"ITEM-4","issued":{"date-parts":[[1986]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Smith, Jones &amp; Brown (1986a); Smith, Jones &amp; Brown (1986b); Smith, Jones, Brown, et al. (1986a); Smith, Jones, Brown, et al. (1986b)
    """
