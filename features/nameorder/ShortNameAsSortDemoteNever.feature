Feature: nameorder
  As a CSL cite processor hacker
  I want the test nameorder_ShortNameAsSortDemoteNever to pass

  @citation @nameorder
  Scenario: Short Name As Sort Demote Never
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
    	  demote-non-dropping-particle="never">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <names variable="author">
            <name form="short" name-as-sort-order="all"/>
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
