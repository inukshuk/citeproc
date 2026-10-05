Feature: label
  As a CSL cite processor hacker
  I want the test label_CompactNamesAfterFullNames to pass

  @citation @label @citation-items
  Scenario: Compact Names After Full Names
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
            <name/>
            <label prefix=", "/>
            <substitute>
              <names variable="translator">
                <name/>
                <label form="short" prefix=" "/>
              </names>
              <names variable="editor"/>
            </substitute>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Alan Aalto, editor |
