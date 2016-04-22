Feature: affix
  As a CSL cite processor hacker
  I want the test affix_PrefixWithDecorations to pass

  @citation @affix @citation-items
  Scenario: Prefix With Decorations
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2007-10-26T21:32:52+02:00</updated>
      </info>
      <citation>
        <layout prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name form="short" />
            </names>
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2000","2","15"]]},"title":"Book C","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","prefix":"<sc>See</sc> "}]]
    """
    Then the results should be:
      | (<span style="font-variant:small-caps;">See</span> Smith 2000) |
