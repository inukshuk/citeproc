Feature: magic
  As a CSL cite processor hacker
  I want the test magic_SubsequentAuthorSubstituteOfTitleField to pass

  @bibliography @magic
  Scenario: Subsequent Author Substitute Of Title Field
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
             subsequent-author-substitute="-----">
        <layout>
          <group delimiter=" ">
            <names variable="author">
              <name and="text" delimiter=", " />
              <substitute>
                <text variable="title"/>
              </substitute>
            </names>
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
    [{"id":"item-1","issued":{"date-parts":[["2000"]]},"title":"Book X","type":"book"},{"id":"item-2","issued":{"date-parts":[["2001"]]},"title":"Book X","type":"book"},{"id":"item-3","issued":{"date-parts":[["2002"]]},"title":"Book Y","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Book X (2000)</div>
      <div class="csl-entry">----- (2001)</div>
      <div class="csl-entry">Book Y (2002)</div>
    </div>
    """
