Feature: decorations
  As a CSL cite processor hacker
  I want the test decorations_AndTermUnaffectedByNameDecorations to pass

  @citation @decorations
  Scenario: And Term Unaffected By Name Decorations
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
        <layout>
          <names variable="author">
            <name and="text">
              <name-part name="family" font-variant="small-caps"/>
              <name-part name="given" font-variant="small-caps"/>
            </name>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false,"suffix":"III"},{"family":"Roe","given":"Jane","non-dropping-particle":"van","static-ordering":false}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    <span style="font-variant:small-caps;">John</span> <span style="font-variant:small-caps;">Doe</span> III and <span style="font-variant:small-caps;">Jane</span> <span style="font-variant:small-caps;">van</span> <span style="font-variant:small-caps;">Roe</span>
    """
