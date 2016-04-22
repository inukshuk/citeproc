Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_YearSuffixMacroSameYearImplicit to pass

  @citation @disambiguate @citations
  Scenario: Year Suffix Macro Same Year Implicit
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
      <citation disambiguate-add-givenname="true" disambiguate-add-year-suffix="true">
        <layout>
          <group delimiter=" ">
            <names variable="author">
              <name form="short" />
            </names>
            <date variable="issued">
              <date-part name="year"/>
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"A"}],"id":"ITEM-1","issued":{"date-parts":[[2001]]},"type":"book"},{"author":[{"family":"Smith","given":"B"}],"id":"ITEM-2","issued":{"date-parts":[[2001]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] A Smith 2001
    >>[1] B Smith 2001
    """
