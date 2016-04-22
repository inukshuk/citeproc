Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_AllNamesSimpleSequence to pass

  @citation @disambiguate
  Scenario: All Names Simple Sequence
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
             disambiguate-add-givenname="true" givenname-disambiguation-rule="all-names">
        <layout delimiter="; " prefix="(" suffix=")">
          <group delimiter=" ">
            <names delimiter=", " variable="author">
              <name and="text" delimiter=", " form="short" />
            </names>
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
    [{"author":[{"family":"Malone","given":"Nolan J.","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2001"]]},"type":"book"},{"author":[{"family":"Malone","given":"Kemp","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1951"]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (Nolan J. Malone 2001; Kemp Malone 1951)
    """
