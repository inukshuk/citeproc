Feature: date
  As a CSL cite processor hacker
  I want the test date_NonexistentSortReverseBibliography to pass

  @bibliography @date
  Scenario: Nonexistent Sort Reverse Bibliography
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
    	  <text value="Dummy"/>
    	</layout>
      </citation>
      <bibliography>
        <sort>
          <key sort="ascending" variable="issued" />
          <key variable="title" />
        </sort>
        <layout>
          <text variable="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Item 1","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[["1999","2","15"]]},"title":"Item 2","type":"book"},{"id":"ITEM-3","title":"Item 3","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[["2000","2","15"]]},"title":"Item 4","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Item 2</div>
      <div class="csl-entry">Item 4</div>
      <div class="csl-entry">Item 1</div>
      <div class="csl-entry">Item 3</div>
    </div>
    """
