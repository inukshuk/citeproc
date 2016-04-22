Feature: magic
  As a CSL cite processor hacker
  I want the test magic_SubsequentAuthorSubstitute to pass

  @bibliography @magic
  Scenario: Subsequent Author Substitute
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
            <name />
          </names>
        </layout>
      </citation>
      <bibliography 
             subsequent-author-substitute="———">
        <layout>
          <group delimiter=" ">
            <group delimiter=", ">
              <names variable="author">
                <name and="text" delimiter=", " />
              </names>
              <text variable="title" />
            </group>
            <date prefix="(" suffix=")" variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John"},{"family":"Roe","given":"Jane"}],"id":"item-1","issued":{"date-parts":[["2000"]]},"title":"Book A","type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Roe","given":"Jane"}],"id":"item-2","issued":{"date-parts":[["2001"]]},"title":"Book B","type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"item-3","issued":{"date-parts":[["2002"]]},"title":"Book C","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">John Smith and Jane Roe, Book A (2000)</div>
      <div class="csl-entry">———, Book B (2001)</div>
      <div class="csl-entry">John Smith, Book C (2002)</div>
    </div>
    """
