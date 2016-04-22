Feature: display
  As a CSL cite processor hacker
  I want the test display_SecondFieldAlignClone to pass

  @bibliography @display
  Scenario: Second Field Align Clone
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
      <macro name="author">
        <names variable="author">
          <name and="text" />
        </names>
      </macro>
      <macro name="date">
        <date variable="issued">
          <date-part name="year" />
        </date>
        <text variable="year-suffix" />
      </macro>
      <citation 
             disambiguate-add-year-suffix="true">
        <layout>
          <text variable="citation-number"/>
        </layout>
      </citation>
      <bibliography 
             subsequent-author-substitute="">
        <layout>
          <text variable="citation-number" prefix="[" suffix="]" display="left-margin"/>
          <group delimiter=" " prefix=" " display="right-inline">
           <group delimiter=", ">
              <text macro="author"/>
              <text variable="title" quotes="true"/>
            </group>
            <text macro="date" prefix="(" suffix=")"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John Aloysius","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[[1999]]},"title":"John's Book","type":"book"},{"author":[{"family":"Roe","given":"Jane Henrietta","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[[2000]]},"title":"Jane's Book","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">
        <div class="csl-left-margin">[1]</div><div class="csl-right-inline"> John Aloysius Doe, “John’s Book” (1999)</div>
      </div>
      <div class="csl-entry">
        <div class="csl-left-margin">[2]</div><div class="csl-right-inline"> Jane Henrietta Roe, “Jane’s Book” (2000)</div>
      </div>
    </div>
    """
