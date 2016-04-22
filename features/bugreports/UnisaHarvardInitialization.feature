Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_UnisaHarvardInitialization to pass

  @bibliography @bugreports
  Scenario: Unisa Harvard Initialization
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <macro name="author">
         <names variable="author">
            <name name-as-sort-order="all" and="symbol" sort-separator=", " initialize-with="" delimiter=", " delimiter-precedes-last="never"/>
            <label form="short" prefix=" (" suffix=")" strip-periods="true"/>
            <substitute>
               <names variable="editor"/>
            </substitute>
         </names>
      </macro>
      <macro name="year-date">
         <choose>
            <if variable="issued">
               <date variable="issued">
                  <date-part name="year"/>
               </date>
            </if>
            <else>
               <text term="no date" form="short"/>
            </else>
         </choose>
      </macro>
      <citation>
        <layout>
          <text value="BOGUS"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text macro="author"/>
          <text macro="year-date" prefix=" " suffix=", "/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John Quiggly"}],"id":"ITEM-1","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Doe, JQ n.d., </div>
    </div>
    """
