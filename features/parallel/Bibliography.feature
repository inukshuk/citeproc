Feature: parallel
  As a CSL cite processor hacker
  I want the test parallel_Bibliography to pass

  @bibliography @parallel @citations @non-standard
  Scenario: Bibliography
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
      <citation year-suffix-delimiter=", ">
        <layout delimiter="; " suffix=".">
          <choose>
          <if position="first">
            <group delimiter=", ">
              <text variable="title"/>
              <group delimiter=" ">
                <text variable="volume"/>
                <text variable="container-title"/>
                <group>
                  <text variable="page"/>
                  <text variable="locator" prefix=", "/>
                </group>
                <date variable="issued" date-parts="year" form="text" prefix="(" suffix=")"/>
              </group>
            </group>
          </if>
          <else-if position="ibid-with-locator">
            <text term="ibid"/>
            <text variable="locator" prefix=" at "/>
          </else-if>
          <else-if position="ibid">
            <text term="ibid"/>
          </else-if>
          <else-if position="subsequent">
            <group delimiter=", ">
              <text variable="title"/>
              <group delimiter=" ">
                <text variable="volume"/>
                <text variable="container-title"/>
                <text variable="locator"/>
              </group>
            </group>
          </else-if>
          <else>
            <text value="WTF?"/>
          </else>
          </choose>
        </layout>
      </citation>
      <bibliography>
        <layout>
    	  <group delimiter=", ">
            <text variable="title"/>
            <group delimiter=" ">
              <text variable="volume"/>
              <text variable="container-title"/>
              <group>
                <text variable="page"/>
                <text variable="locator" prefix=", "/>
              </group>
              <date variable="issued" date-parts="year" form="text" prefix="(" suffix=")"/>
            </group>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"container-title":"U.S.","id":"ITEM-1","issued":{"date-parts":[["1965"]]},"page":"200","title":"Smith v. Noakes","type":"legal_case","volume":"222"},{"container-title":"L.Ed.","id":"ITEM-2","issued":{"date-parts":[["1965"]]},"page":"300","title":"Smith v. Noakes","type":"legal_case","volume":"333"},{"container-title":"U.S.","id":"ITEM-3","issued":{"date-parts":[["1965"]]},"page":"400","title":"Jim v. Bob","type":"legal_case","volume":"444"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Jim v. Bob, 444 U.S. 400 (1965)</div>
      <div class="csl-entry">Smith v. Noakes, 222 U.S. 200, 333 L.Ed. 300 (1965)</div>
    </div>
    """
