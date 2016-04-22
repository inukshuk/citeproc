Feature: sort
  As a CSL cite processor hacker
  I want the test sort_NameVariable to pass

  @bibliography @sort
  Scenario: Name Variable
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
            <text value="Ignore me"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author"/>
        </sort>
        <layout>
          <names variable="author">
            <name/>
          </names>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","type":"book"},{"author":[{"family":"[F]linders","given":"Jacob","static-ordering":false}],"id":"ITEM-3","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">John Doe</div>
      <div class="csl-entry">Jacob [F]linders</div>
      <div class="csl-entry">Jane Roe</div>
    </div>
    """
