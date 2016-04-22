Feature: sort
  As a CSL cite processor hacker
  I want the test sort_StatusFieldAscending to pass

  @bibliography @sort
  Scenario: Status Field Ascending
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
        <layout delimiter=", ">
    	  <text variable="title"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="status" sort="ascending"/>
          <key variable="title"/>
        </sort>
        <layout>
    	  <text variable="title"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"},{"id":"ITEM-2","status":"forthcoming","title":"Book B","type":"book"},{"id":"ITEM-3","title":"Book C","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Book B</div>
      <div class="csl-entry">Book A</div>
      <div class="csl-entry">Book C</div>
    </div>
    """
