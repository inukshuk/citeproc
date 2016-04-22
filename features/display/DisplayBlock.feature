Feature: display
  As a CSL cite processor hacker
  I want the test display_DisplayBlock to pass

  @bibliography @display
  Scenario: Display Block
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
          <text value="hello" />
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=" ">
            <group delimiter=", ">
              <names variable="author">
                <name />
              </names>
              <text variable="title" />
            </group>
            <date prefix="(" suffix=")" variable="issued">
              <date-part name="year" />
            </date>
          </group>
          <text display="indent" variable="abstract" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"abstract":"An interesting book by an interesting author.","author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2000"]]},"title":"Book A","type":"book"},{"abstract":"An old contribution to a new field.","author":[{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["2001"]]},"title":"Book B","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">John Smith, Book A (2000)<div class="csl-indent">An interesting book by an interesting author.</div>
      </div>
      <div class="csl-entry">Robert Jones, Book B (2001)<div class="csl-indent">An old contribution to a new field.</div>
      </div>
    </div>
    """
