Feature: magic
  As a CSL cite processor hacker
  I want the test magic_ImplicitYearSuffixDelimiter to pass

  @citation @magic
  Scenario: Implicit Year Suffix Delimiter
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
      <citation disambiguate-add-year-suffix="true" collapse="year-suffix">
        <layout delimiter="; ">
          <group delimiter=" ">
            <names variable="author">
              <name />
            </names>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[["1965"]]},"type":"book"},{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[["1965"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe 1965a; b
    """
