Feature: bibsection
  As a CSL cite processor hacker
  I want the test bibsection_Quash to pass

  @bibliography @bibsection
  Scenario: Quash
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
          <text value="Oops"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
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
    [{"id":"ITEM-1","title":"Manuscript C","type":"manuscript"},{"id":"ITEM-2","issued":{"date-parts":[[2000,11,1]]},"title":"Article B","type":"article-journal"},{"id":"ITEM-3","issued":{"date-parts":[[2000,12,1]]},"title":"Book A","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[[1850,12,1]]},"title":"Manuscript D","type":"manuscript"}]
    """
    When I render the following bibliography selection:
    """
    {"quash":[{"field":"type","value":"manuscript"},{"field":"issued","value":""}]}
    """
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Article B</div>
      <div class="csl-entry">Book A</div>
      <div class="csl-entry">Manuscript D</div>
    </div>
    """
