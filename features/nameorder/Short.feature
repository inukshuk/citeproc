Feature: nameorder
  As a CSL cite processor hacker
  I want the test nameorder_Short to pass

  @citation @nameorder
  Scenario: Short
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
            <name form="short"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"dropping-particle":"de","family":"Martinière","given":"Gérard","non-dropping-particle":"la","static-ordering":false,"suffix":"III"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    la Martinière
    """
