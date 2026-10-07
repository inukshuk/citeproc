Feature: number
  As a CSL cite processor hacker
  I want the test number_OrdinalSpacing to pass

  @citation @number @citation-items @non-standard
  Scenario: Ordinal Spacing
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
      <citation>
        <layout delimiter="; ">
          <text value="Blah blah"/>
          <group delimiter="DD" prefix=". "
    >
            <number variable="edition" form="ordinal"/>
            <text term="edition" font-style="italic" form="short" strip-periods="true"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":"7, p. 3-8","id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Blah blah. 7th, pp. 3–8DD<i>ed</i> |
